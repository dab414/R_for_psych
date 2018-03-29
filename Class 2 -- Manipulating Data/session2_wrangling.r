#### CLASS 2

## We're going to cover packages, working directories, importing data, data.table, and dplyr... or we'll at least try

## TOPIC 1: PACKAGES
	## a package is essentially a bunch of code someone else has written to make your life in R easier.
	## remember last week when (for your exercise) i told you to click 'source on save' in the script you were writing?
	## that's essentially what's happening when you load a package -- R is loading scripts that contain functions that you can use to do cool things
		## for example, R has a lot of plotting functions built in, but everyone knows that all the cool plotting functions are in a package that you need to load
		## once you load this package, you can use these functions to make beautiful graphs that everyone will love
	## you only need to install packages once, but you need to load packages every time you start up R

	# for installing a package, run this code:
		install.packages('package') # where you replace the word package with the name of the package you want to install (but keep the quotes!)
	# try this:
		install.packages('data.table')
	# then load it like this:
		library(data.table) # notice you don't need the quotes anymore
	# to get more information about a package, go like this:
		help(data.table) # this help page will prob be confusing at first, but that's okay cuz that's what I'm here for

	# install and load the following packages: dplyr, ggplot2

	# your code here

		
		
## TOPIC 2: WORKING DIRECTORIES
	# when you're typing commands in your R console and you want R to interact with the files on your computer, R is always 'operating' out of a certain folder on your hard drive
	# to see what that folder is right now, run:
	getwd()
	# in RStudio, you can easily change this by pressing ctl + shift + h, idk what it is for mac, sorry. but you can navigate the menus
	# or you can do this:
	setwd('/desired/working/directory') #obv change the text to a folder on your file system, using forward slashes EVEN on windows

	# but the truly dope way to set working directories is by using projects, and I'll do this live

## TOPIC 3: LOADING DATA
	# loading data becomes much easier to understand once you grasp the concept of working directories
	# if i tell R to load data, it's much easier to tell R where to look for the data on my file system if I tell it where to look relative to R's working directory
	# it's the difference between this (easier) way:
	'data/current_data.csv'
	# and this (hard) way:
	'C:/garbage/garbage/more_garbage/even_more_garbage/data/current_data.csv'

	# there are plenty of functions for loading data, and I'm copy and pasting in some of the main ones:

	## READ.TABLE(), a very common way to handle lots of different data types
		# first row contains variable names, comma is separator 
		# assign the variable id to row names
		# note the / instead of \ on mswindows systems 

		mydata <- read.table("mydata.csv", header=TRUE, 
		  	sep=",", row.names="id")

		# there is also read.csv(), which is faster to type if your data is a csv
		mydata <- read.csv('mydata.csv', header = TRUE)

	## FROM EXCEL
		# read in the first worksheet from the workbook myexcel.xlsx
		# first row contains variable names
		library(xlsx)
		mydata <- read.xlsx("c:/myexcel.xlsx", 1)

		# read in the worksheet named mysheet
		mydata <- read.xlsx("c:/myexcel.xlsx", sheetName = "mysheet")

	## FROM SPSS
		# save SPSS dataset in trasport format (THIS IS SPSS SYNTAX)
			get file='c:\mydata.sav'.
			export outfile='c:\mydata.por'. 

			# in R 
			library(Hmisc)
			mydata <- spss.get("c:/mydata.por", use.value.labels=TRUE)
			# last option converts value labels to R factors

	## FROM SAS
		# save SAS dataset in trasport format (THIS IS SAS SYNTAX)
		libname out xport 'c:/mydata.xpt';
		data out.mydata;
		set sasuser.mydata;
		run;

		# in R 
		library(Hmisc)
		mydata <- sasxport.get("c:/mydata.xpt")
		# character variables are converted to R factors

	## FROM STATA
		# input Stata file
		library(foreign)
		mydata <- read.dta("c:/mydata.dta")

	## FROM SYSTAT
		# input Systat file
		library(foreign)
		mydata <- read.systat("c:/mydata.dta")

##### MY PERSONAL FAV WAY OF IMPORTING DATA
	# comes from data.table(), called fread()

	mydata <- fread('mydata.csv')

	# this one performs much faster than the others (good for big data), it tends to handle data correctly by default, and has a ton of options if you wanna mess: 
		#https://www.rdocumentation.org/packages/data.table/versions/1.10.4-2/topics/fread

### TOPIC 4: SUMMARIZING DATA WITH DATA.TABLE() and DPLYR()

  ## last week we talked about working with data frames as the most relevant way for us psychologists to think about manipulating data in R
  ## now we're introducing two packages that are specialially specially designed for making working with data easier
  ## these packages are also primo for working with big data
  ## more than you ever wanted to know about dplyr vs data.table:
    # https://github.com/Rdatatable/data.table/wiki/Benchmarks-:-Grouping
    #TLDR: data.table is slightly faster, dplyr has more readable code

  ## we're often in a position where we need to summarize across subjects and then summarize across conditions to get cell means
  ## and we need to do this over and over for all different possible ways of looking at data
  ## data.table and dplyr both provide easy ways of doing this

  # read data
  current_data <- fread('http://lehigh.edu/~dab414/data/research_data/old/special_issue/easy_clean.csv')

  # check things out
  head(current_data)
  str(current_data)

  # by running str, i can see that my factors 'current' and 'other' are strings, and i need them as factors:
  current_data$current <- as.factor(current_data$current)
  current_data$other <- as.factor(current_data$other)

  # same with subject
  current_data$subject <- as.factor(current_data$subject)

  ## we'll start with data.table(), bc it's very similar to data.frame()
  ## basically:

    # dt[rows, columns, by = ]
    # so same as data frame, except now there's this third 'by' argument that we can use to summarize by groups
    # also (in the columns argument) we're telling data.table what operations to perform when summarizing
      # whereas in data.frame, this argument is only used for telling data.frame which columns we're interested in grabbing
    # one weird quirck about DT is that (when you're passing more than one var to a single argument) data.table wants it to be passed in a list
      # so instead of c(), we use .(), idk why

  ## so to get means for my factors by subject (transcode is my dv, btw)
  
    # (maybe quickly demo how to do it in data.frame, the DUMB way)

    #convert to data table
    current_data <- as.data.table(current_data)
    # make new dataset with subject means (note im leaving the 'row' entry blank because i don't want to filter out rows)
    subject_means <- current_data[, .(switch = mean(transcode)), by = .(subject, current, other)]
    # look at the data
    subject_means # note data.table is smart and won't assault you by outputing the entire dataset if it's too big
  
    # how would you compute subject means (just like above) but only keep data that occurs after block 5?

      # your code here

    
    
    
    # to condense to cell means:
      cell_means <- subject_means[, .(switch = mean(switch)), by = .(current, other)]

    # cell means with SEs:
      cell_means <- subject_means[, .(switch = mean(switch), se = sd(switch) / sqrt(.N)), by = .(current, other)]      


  ## doing the same thing with dplyr
  # important functions are, group_by(), summarize()

    subject_means <- current_data %>%
      group_by(subject, current, other) %>%
      summarize(transcode = mean(transcode)) %>%
      ggplot()

    cell_means <- subject_means %>%
      group_by(current, other) %>%
      summarize(switch = mean(transcode), se = sd(transcode) / sqrt(n()))

  ## data table and dplyr can both do these in one step

    # data table
      cell_means <- current_data[, .(switch = mean(transcode)), by = .(subject, current, other)][, .(switch = mean(switch), se = sd(switch) / sqrt(.N)), by = .(current, other)][order(current,other)]
    
    # dplyr
      cell_means <- current_data %>%
        group_by(subject, current, other) %>%
        summarize(transcode = mean(transcode)) %>%
        group_by(current, other) %>%
        summarize(switch = mean(transcode), se = sd(transcode) / sqrt(n()))

## A NOTE OF WARNING

  ## indexing a data table or 'tibble' (as it's returned in dplyr) doesn't always return a vector like data.frame

    #compare

    current_data_df <- as.data.frame(current_data)

    # data frame return type
    current_data_df[1:5, 'current']
    # data table
    current_data[1:5, 'current']
    # dplyr
    subject_means[1:5, 'transcode']

  ## this doesn't usually matter, but it's good to be aware of
  ## to get a vector back from data table or dplyr, use the dollar sign indexing
    current_data$current[1:5]
    
    
    
    
    
    
    
    
    
