## pulling from http://r-statistics.co/Complete-Ggplot2-Tutorial-Part1-With-R-Code.html

options(scipen = 999) ## disabling scientific notation

## SESSION 3 -- GGPLOT

	## Strap on your seat belts, we're about to dive into one of R's biggest strengths: plotting.
		## Or if you want to be trendy, you can call it "data visualization". 

	## It's highly recommended that you understand the concepts covered in the first two sessions, but it's not absolutely mandatory.
		## to put this session within a broader context:
		## you'll want to use the techniques covered in the previous sessions to prepare your data for plotting
		## then, once you have the data in the form you want, you'll use the techniques below for plotting

## 1 - UNDERSTANDING GGPLOT SYNTAX
	## ggplot is nice because it easily works with entire dataframes instead of individual vectors

	## let's load in data that we'll be plotting
	library(ggplot2) # the library necessary to use ggplot
	data('midwest', package = 'ggplot2')
	head(midwest)
	str(midwest)

	## there's actually a lot going on here, but without going too bonkers with descriptives right now, my guess is we're looking at population statistics from states in the midwest
	## it's already "tidied", which is the format we'll need it to be in in order to plot

	## let's make the base layer for a plot
	ggplot(data = midwest, aes(x = area, y = poptotal))
		## R gives us a beautiful graph with... nothing in it
		## ggplot isn't making any assumptions as to what TYPE of graph you want yet, we've only specified the axes. specifying graph type comes next

	## we add layers to a plot by specifying "geom" layers, in this case we'll make a scatter plot
	ggplot(midwest, aes(x = area, y = poptotal)) + geom_point()

	## add a line of best fit
	ggplot(midwest, aes(x = area, y = poptotal)) + geom_point() + geom_smooth(method = 'lm')

	## adjust axes range and delete points outside of range
	## this is the first time i'm going to save the plot to an object and build on it in a layered fashion
	p <- ggplot(midwest, aes(x = area, y = poptotal)) + geom_point() + geom_smooth(method = 'lm')
	p + ylim(0, 1000000) 
	
	## adjust axes by simply zooming in
	p1 <- p + coord_cartesian(ylim = c(0, 1000000))

	## adding titles and labels
	p1 + labs(title = 'Area Vs Population', subtitle = 'From midwest dataset', y = 'Population', x = 'Area', caption = 'Midwest Demographics')

	# or 

	p1 + ggtitle("Area Vs Population", subtitle="From midwest dataset") + xlab("Area") + ylab("Population")

	## and we can chain all of this together:
	ggplot(midwest, aes(x = area, y = poptotal)) + 
	  geom_point() + 
	  geom_smooth(method = 'lm') + 
		ylim(0, 1000000) + 
	  ggtitle("Area Vs Population", subtitle="From midwest dataset") + 
	  xlab("Area") + 
	  ylab("Population")
	

## CHANGING GRAPH APPEARANCE

	## change color and point size
	ggplot(midwest, aes(x=area, y=poptotal)) + 
	  geom_point(col="steelblue", size=3) +   # Set static color and size for points
	  geom_smooth(method="lm", col="firebrick") +  # change the color of line
	  coord_cartesian(xlim=c(0, 0.1), ylim=c(0, 1000000)) + 
	  labs(title="Area Vs Population", subtitle="From midwest dataset", y="Population", x="Area", caption="Midwest Demographics")

	## USING COLORS TO PLOT TWO FACTORS AT ONCE
	p1 <- ggplot(midwest, aes(x=area, y=poptotal)) + 
	  geom_point(aes(col=state), size=3) +  # When you put arguments inside aes(), generally it'll vary based on state categories.
	  geom_smooth(method="lm", col="firebrick", size=2) + 
	  coord_cartesian(xlim=c(0, 0.1), ylim=c(0, 1000000)) + 
	  labs(title="Area Vs Population", subtitle="From midwest dataset", y="Population", x="Area", caption="Midwest Demographics")
	p1

	## Sometimes legends suck!! Here's how to get rid:
	p1 + theme(legend.position = 'none')

	## Switch up the color palette!
	p1 + scale_color_brewer(palette = 'Set1')

### CHANGE X AXIS TEXTS AND TICKS LOCATION

# Base plot
gg <- ggplot(midwest, aes(x=area, y=poptotal)) + 
  geom_point(aes(col=state), size=3) +  # Set color to vary based on state categories.
  geom_smooth(method="lm", col="firebrick", size=2) + 
  coord_cartesian(xlim=c(0, 0.1), ylim=c(0, 1000000)) + 
  labs(title="Area Vs Population", subtitle="From midwest dataset", y="Population", x="Area", caption="Midwest Demographics")

# Change breaks
gg + scale_x_continuous(breaks=seq(0, 0.1, 0.01))

## look at what the seq() function does:
seq(0, 0.1, 0.01)

# Change breaks & labels
gg + scale_x_continuous(breaks=seq(0, 0.1, 0.01), labels = letters[1:11]) ## labels argument must be same length as breaks

## REVERSE REVERSE
gg + scale_x_reverse()

## change axis labels as a function of what they already are -- kinda advanced
gg <- gg + scale_x_continuous(breaks=seq(0, 0.1, 0.01), labels = sprintf("%1.2f%%", seq(0, 0.1, 0.01))) + 
  scale_y_continuous(breaks=seq(0, 1000000, 200000), labels = function(x){paste0(x/1000, 'K')})
gg

## CHANGING ENTIRE THEME ALL AT ONCE
gg + theme_bw() + labs(subtitle = 'BW Theme')
gg + theme_classic() + labs(subtitle = 'Classic Theme')

## DISPLAY EVEN MORE FACTORS -- Faceting

	## facet wrap
	## takes a formula as main argument: items to the left of the `~` are rows, items to the right are columns
	## we'll use a different dataset for this one
		head(mpg)
		str(mpg)

	g <- ggplot(mpg, aes(x = displ, y = hwy)) + 
					geom_point() + 
					geom_smooth(method = 'lm', se = FALSE) + 
					theme_bw() +
					labs(title = 'Hwy vs Displ', caption = 'Source: mpg', subtitle = 'Ggplot2 - Faceting - Multiple plots in one figure')

	## facet wrap 
	g + facet_wrap( ~ class)

	## facet grid
	g + facet_grid( ~ class)

	## facet grid with extra var
	g + facet_grid(cyl ~ class)


## bar plot with error bars, general code
b <- ggplot(data, aes(x = factor1, y = dv)) + geom_bar(stat = 'identity', aes(fill = factor2), position = position_dodge(width = .9))
b + geom_errorbar(aes(ymin = mean - se, ymax = mean + se, group = factor2), position = position_dodge(width = .9), width = .5)

## line plot, general code
ggplot(data, aes(x = factor1, y = dv)) + geom_line(aes(col = factor2))


## hall of fame http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html