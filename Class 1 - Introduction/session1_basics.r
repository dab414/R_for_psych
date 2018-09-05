### SESSION 1 -- BASIC DATA MANEUVERS & DATA STRUCTURES

### Getting the hang of the R workflow can be a little tricky, and I imagine this is the first thing I'll go over in class

### R AS A CALCULATOR

	## This is similar to any programming lanugage, where you have basic operations that will do predictable things

		1 + 1 #returns 2; all other basic operations work similarly (-, /, *) 
    a <- 1 + 1
		
	## Assignment, how we tell R to store a variable using the weird '<-' assignment operator

		a <- 5 # a now equals five, this won't return any output, but you'll see in the environment window that a is now stored as a variable
		b <- 6
		a + b # returns 11, pretty predictable

### VECTORS
	# Understanding vector logic is CRUCIAL 
	# You can kind of think of this like a column in a dataset, it contains a bunch of (usually similar types of) data

	# Initializing a simple vector:
	x <- c(5, 4, 3, 2, 1) # c just means concatenate, it's Rs way of knowing that you want to treat each number as a separate elemenet within a vector
	x # outputs the vector to the console
	x <- 5:1 # is the same thing as above

	x * 2 # returns a vector with the same length of x where each element is multiplied by 2
			# this basic idea becomes critical when you want to compute a new variable as a function of an existing variable times another, for example
			# notice the variable x stays the same as it was before, it only changes in memory if we assign the output to itself, like:
	x <- x * 2 # NOW x is updated, but let's keep it how it was for now
	x <- x / 2

	## INDEXING VECTORS
		# the logic of indexing is so weird and so important
		# you use square brackets [] for immediately after the variable name for indexing any data object
		x[2] # returns the second element of variable x, in this case the element 4

		## you can also return a slice of a vector, using the ':' symbol
		x[2:4] # returns a vector containing the second through the fourth elements 

		## you can also index a vector with a vector (it's starting to get weird)
		x[c(1,2,4)] # returns the first, second, and fourth element of vector x, and it returns this as a vector
		## it would be the same thing as going like this:
		y <- c(1,2,4)
		x[y] ## but now you can see how the syntax can get all tricky and nested

		## you can also index with what's called a logical, basically passing a True/False statement and it returns all elements of the vector that are 'True'
		x[x>2] # returns '5,4,3'; notice how you have to refer to the vector again inside the vector

		## you can also pass multiple conditionals with & (and), | (or)
		x[x>2 & x<5] ## notice how you have to refer to x AGAIN on the other side of the logical joiner (the &)
    
		## this is super useful for trimming datasets according to some criterion, like remove all rows from the data where the 'error' variable equals TRUE (indicating there was an error)
		## but you could index a vector by any logical, for example:
		x <- c('red','blue','green','orange','purple')
		y <- 15:19
		x[x>17] 
		## this will return '2, 1', why?

	## vectors are so crucial because, for certain analyses, you'll need to refer to vectors inside a dataset to tell the function what to analyze or how to trim something
		## the more comfortable you are with the logic of vectors, the more your unlimited analysis power is unleashed

	## TYPES OF VECTORS (i.e., variables)

		s <- c('a','b','c') # a character vector
		f <- c('red','red','red','blue','blue','blue') # a factor vector
		n <- c(1,2,3) # a numeric vector

		## notice f and s are the same in the sense that they're both vectors storing characters, but let's say we want one to act as a factor
		## you can check what 'type' an object is by using either of the following
		typeof(f)
		class(f)
		## this tells us that f is actually a character vector, not good
			## i honestly can't really tell you the difference between typeof() and class(), but just in general try both if one isn't making sense
		## but we can change variable types by:
		f <- as.factor(f) ## also as.character(), and as.numeric(), among others

		## now doing our checks gives us a different answer:
		typeof(f)
		class(f)
			## see how typeof() returns integer... who knows



### general functions that are handy for working with data objects

	summary(f) ## returns detail about whatever object you give it
	str(f) ## same idea, but focuses on the types of variables in any given object
	head(f) ## returns the first few entries of an object, useful for looking at the first few rows of a large dataset
	hist(x) ## returns a quick histogram of a vector, the object that you pass to it must be a numeric vector (wouldn't make sense otherwise)



## im gonna freestyle going over data.frame(), which is actually the most useful concept for us psychologists
## but once you master vectors the logic of data.frame() is WAY easier
	
library(MASS)

## we're using a dataset that R basically has built in
df <- ToothGrowth

## always a good idea to run this whenever you've imported data
summary(df)

## this gives you an Excel-type way of looking at the rows and columns of the data
	## helpful for easing that separation anxiety from the data when you're first starting out
View(df)

## the same general rules for indexing that apply to vectors also apply to data.frames, except now you need to specify two indices because the data frame has rows and columns
#  df[rows , columns]
df[3,2]

df[5:10,1]
df$len
df$len[5]

df[5,1]

## different ways of getting same information
df$len[5:10]
df[5:10, 1]
df[5:10,]

df[df$len > 10,]

# return all columns by leaving blank after comma
df2 <- df[df$len > 10, ]


## coding a new variable
	## the following line computes a new centered variable by taking the whole vector length (df$len) and subtracting from each element the mean of length (mean(df$len))
df$len_c <- df$len - mean(df$len)

df$lenX2[3] <- 10

colnames(df)[4] <- 'new_var'

## ifelse(conditional, iftrue, if_false)
df$len_d <- ifelse(df$len > median(df$len), 1, 0)

## ifelse can get nested, can get confusing
df$len_d <- ifelse(df$len > 10, 2, ifelse(df$len > 4 & df$len < 10, 1, 0))


## for help, help()
help(ifelse)
?ifelse()



	