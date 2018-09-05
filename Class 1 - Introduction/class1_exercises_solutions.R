
## for each exercise, follow the directions and make sure to put the result inside the parentheses of return()
## to test your answers, check the "Source on Save" box, save the script, and type ">main()" into the console (without the greater than sign). 

library(MASS)

exercise1 <- function(){
  ## assign the values 5 and 6 to variables a and b, and return their sum
  
  ## your code here
  a <- 5
  b <- 6
  
  return(a + b)
  
}


exercise2 <- function(){
  df <- data.frame(blue = 1:5, green = c(7,5,3,1,8), red = c(1.5,7.9,1.4,5.6,1.1))
  
  ## return the third row of the column 'red' in the data frame 'df'
  
  ## your code here
  result <- df[3,'red']
  
  return(result)
  
}


exercise3 <- function(){
  set.seed(500)
  fruit_data <- data.frame('pear' = runif(50), 'lemon' = runif(50), 'apple' = runif(50), 'grapes' = runif(50))
  
  ## return all rows of the dataset 'fruit_data' where the values of the 'lemon' variable are greater than .25, and the values of the 'pear' variable are less than .75
  ## make a new variable called 'orange' that is equal to 'pear' times 'lemon'
  ## return the mean of oranges times the mean of lemons
  
  
  ## your code here
  fruit_data <- fruit_data[fruit_data$lemon > .25 & fruit_data$lemon < .75,]
  pear <- fruit_data$pear
  fruit_data$orange <- pear * fruit_data$lemon
  result <- mean(fruit_data$orange) * mean(fruit_data$lemon)
  
  return(result)
  
}

exercise4 <- function(){
  ## Exercise 4 -- kinda hard
  ## for the 'freeny' dataset, make a new variable with value equal to 1 if income.level is greater than or equal to 6 and market.potential is greater than 13
  ## otherwise, return a 2 if price.index is between 4.60 and 4.65, otherwise return a 0
  ## return the mean of this new variable
  
  ## your code here
  freeny$new <- with(freeny, ifelse(income.level >= 6 & market.potential > 13, 1, ifelse(price.index <= 4.65 & price.index >= 4.60,2,0)))
  
  
  return(mean(freeny$new))
  
}

exercise5 <- function(){
  tooth <- ToothGrowth
  
  ## Exercise 5 -- ADVANCED
  ## the dataset 'tooth looks at the effect of Vitamin C on tooth growth in guinea pigs
  ## in the this dataset, run a t-test that tests the influence of supplemant (supp) on tooth length (each row represents one guinea pig)
  ## return all the results of the t-test, the p-value from this output will be extracted to test your result
  ## hint: the t-test function is: t.test()

  t.test(vector1, vector2)
  
  result <- t.test(tooth[tooth$supp == 'OJ','len'], tooth[tooth$supp == 'VC', 'len'])
  
  return(result)
  
}

exercise6 <- function(){
  df <- freeny
  ## Exercise 6 -- The INSANITY challenge
  ## round market potential to nearest tenth
  ## trim the whole dataset to only keep observations on the market.potential variable from the fifth occurance of 13.0 to the thirteenth occurance of 13.1
  ## return the mean of income level
  ## and if you think you're real hard, do it all in one line of code
  ## you'll prob never have to do something like this on real data, but it's good to be a champ in general
  
  
  return(mean(df[which(round(df$market.potential,1) == 13.0)[5] : which(round(df$market.potential,1) == 13.1)[13],]$income.level))
  
  
}



###!!!!!!! DON'T CHANGE ANYTHING BELOW HERE !!!! #######
#############################################################













test <- function(got, expected){
  
  if (got == expected) { 
    prefix <- 'Ok'
  } else prefix <- 'X'
  
  paste(prefix, 'got:', got, 'expected:', expected)
  
}

main <- function(){
  
  
  if(!is.null(exercise1())){
    print(test(exercise1(), 11))
  } else print("Exercise 1 is not returning any output. Did you put a value inside the parentheses of 'return()'?")
  
  if(!is.null(exercise2())){
    print(test(exercise2(), 1.4))
  } else print("Exercise 2 is not returning any output. Did you put a value inside the parentheses of 'return()'?")
  
  if(!is.null(exercise3())){
    print(test(round(exercise3(),2), 0.1))
  } else print("Exercise 3 is not returning any output. Did you put a value inside the parentheses of 'return()'?")
  
  if(!is.null(exercise4())){
    print(test(round(exercise4(),2), 1.03))
  } else print("Exercise 4 is not returning any output. Did you put a value inside the parentheses of 'return()'?")
  
  if(!is.null(exercise5())){
    print(test(round(exercise5()$p.value, 2), 0.06))
  } else print("Exercise 5 is not returning any output. Did you put a value inside the parentheses of 'return()'?")
  
  if(!is.null(exercise6())){
    print(test(round(exercise6(), 2), 6.02))
  } else print("Exercise 5 is not returning any output. Did you put a value inside the parentheses of 'return()'?")
  
  
}







