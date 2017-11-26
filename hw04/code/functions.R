#@title: HW04 - Grades Visualizer
#@description: Working with raw data,data preparation, and reformatting

##Function remove_missing()
#' @title: remove_missing
#' @description: remove the missing value of a vector
#' @input: x vector
#' @output: vector without missing value
#' @example: 
#' remove_missing(a)
remove_missing <- function(x){
  x <- x[!is.na(x)]
    return(x) #@output
}

##Function get_minimum()
#' @title: get_minimum
#' @description: get minimum value of a vector
#' @input: x vector
#' @input: na.rm whether to remove missing values
#' @output: vector's minimum value
#' @example: 
#' get_minimum(b)
get_minimum <- function(x, na.rm = TRUE){
  x <- remove_missing(x)
  if(is.numeric(x)){
    x<-sort(x, decreasing = FALSE)
    min_value<-x[1]
    return(min_value) #@output
  }
  else{print("This is not a numeric vector.")}
}

##Function get_maximum()
#' @title: get_maximum
#' @description: get maximum value of a vector
#' @input: x vector
#' @input: na.rm whether to remove missing values
#' @output: vector's maximum value
#' @example: 
#' get_maximum(c)
get_maximum <- function(x, na.rm = TRUE){
  x <- remove_missing(x)
  if(is.numeric(x)){
    x <- sort(x, decreasing = TRUE)
    max_value <- x[1] 
    return(max_value) #@output
  }
  else{print("This is not a numeric vector.")}
}


##Function get_range()
#' @title: get_range
#' @description: get range of a vector
#' @input: x vector
#' @input: na.rm whether to remove missing values
#' @output: vector's range
#' @example: 
#' get_range(d)
get_range <- function(x, na.rm = TRUE){
  x <- remove_missing(x)
  if(is.numeric(x)){
    range <- get_maximum(x) - get_minimum(x)
    return(range) #@output
  }
  else{print("This is not a numeric vector.")}
}


##Function get_percentile10()
#' @title: get_percentile10
#' @description: get percentile10 of a vector
#' @input: x vector
#' @input: na.rm whether to remove missing values
#' @output: vector's percentile10
#' @example: 
#' get_percentile10(z)
get_percentile10 <- function(x, na.rm = TRUE){
  x <- remove_missing(x)
  if(is.numeric(x)){
    x <- quantile(x, 0.10, names = FALSE)
    return(x)
  }
  else{print("This is not a numeric vector.")}
}


##Function get_percentile90()
#' @title: get_percentile90
#' @description: get percentile90 of a vector
#' @input: x vector
#' @input: na.rm whether to remove missing values
#' @output: vector's percentile90
#' @example: 
#' get_percentile90(z)
get_percentile90 <- function(x, na.rm = TRUE){
  x <- remove_missing(x)
  if(is.numeric(x)){
    x <- quantile(x, 0.90, names = FALSE)
    return(x)
  }
  else{print("This is not a numeric vector.")}
}


##Function get_median()
#' @title: get_median
#' @description: get median of a vector
#' @input: x vector
#' @input: na.rm whether to remove missing values
#' @output: vector's median
#' @example: 
#' get_median(e)
get_median <- function(x, na.rm = TRUE){
  x <- remove_missing(x)
  x <- sort(x,decreasing = FALSE)
  if(is.numeric(x)){
  if(length(x) %% 2 == 0){
      median <- (x[length(x) / 2] +x[(length(x) / 2) + 1]) / 2
      return(median) #@output
    }
  else{
      median <- x[length(x) / 2 + 0.5]
      return(median) #@output 
  }}
  else{print("This is not a numeric vector.")}
}

##Function get_average()
#' @title: get_average
#' @description: get average of a vector
#' @input: x vector
#' @input: na.rm whether to remove missing values
#' @output: vector's average
#' @example: 
#' get_average(f)
get_average <- function(x, na.rm = TRUE){
  x <- remove_missing(x)
  if(is.numeric(x)){
    result = 0
    for(i in 1:length(x)){
      result <- result + x[i]
      }
      ave_value <- result / length(x)
      return(ave_value) #@output
  }
  else{print("This is not a numeric vector.")}
}


##Function get_stdev()
#' @title: get_stdev
#' @description: get standard deviation of a vector
#' @input: x vector
#' @input: na.rm whether to remove missing values
#' @output: vector's standard deviation
#' @example: 
#' get_stdev(g)
get_stdev <- function(x, na.rm = TRUE){
  x <- remove_missing(x)
  if(is.numeric(x)){
  result = 0
   for(i in 1:length(x)){
     result = (result + ((x[i]-get_average(x))^2))}
  SD <- sqrt(result / (length(x) - 1))
  return(SD) #@output
  }
  else{print("This is not a numeric vector.")}
}



##Function get_quartile1()
#' @title: get_quartile1
#' @description: get the first quartile of a vector
#' @input: x vector
#' @input: na.rm whether to remove missing values
#' @output: vector's first quartile
#' @example: 
#' get_quartile1(h)
get_quartile1 <- function(x, na.rm = TRUE){
  x <- remove_missing(x)
  if(is.numeric(x)){
  value <- quantile(x, names = FALSE)[2]
  return(value) #@output
  }
  else{print("This is not a numeric vector.")}
}



##Function get_quartile3()
#' @title: get_quartile3
#' @description: get the third quartile of a vector
#' @input: x vector
#' @input: na.rm whether to remove missing values
#' @output: vector's third quartile
#' @example: 
#' get_quartile3(i)
get_quartile3 <- function(x, na.rm = TRUE){
  x <- remove_missing(x)
  if(is.numeric(x)){
    value <- quantile(x, names = FALSE)[4]
    return(value) #outout
  }
  else{print("This is not a numeric vector.")}
}


##Function count_missing()
#' @title: count_missing
#' @description: count the vector's missing values
#' @input: x vector
#' @output: vector's number of missing values
#' @example: 
#' count_missing(j)
count_missing <- function(x){
  if(is.numeric(x)){
    x <- x[is.na(x)]
    value <- length(x)
    return(value) #@output
  }
  else{print("This is not a numeric vector.")}
}

##Function summary_stats()
#' @title: summary_stats
#' @description: returns a list of summary statistics
#' @input: x vector
#' @input: na.rm whether to remove missing values
#' @example: 
#' summary_stats(k)
summary_stats <- function(x, na.rm = TRUE)
{if(is.numeric(x))
  { value <- list(
      minimum = get_minimum(x), percent10 = get_percentile10(x),
      quartile1 =  get_quartile1(x), median =  get_median(x),
      average =  get_average(x), quantile3 =  get_quartile3(x),
      percent90 = get_percentile90(x), maximum =  get_maximum(x),
      range =  get_range(x), stdev =  get_stdev(x), 
      missing = count_missing(x))
    return(value)} #@output 
  else{print("This is not a numeric vector.")}
}


##Function print_stats()
#' @title: print_stats
#' @description:  prints the values in a nice format
#' @input: x vector
#' @input: na.rm whether to remove missing values
#' @example: 
#' print_stats(stats)
print_stats <- function(x, na.rm = TRUE){
  x<-summary_stats(x)
  if(is.list(x)){
    for(i in 1:length(x)){
    name <- format(names(x[i]), width = max(nchar(names(x[i]))))
    x1 <- as.numeric(x[i])
    x2 <- format(round(x1, 4), nsmall = 4)
    y <- paste(name, ":", x2, sep = "")
    cat(y, '\n') #return(y) #@output
    }
  }
  else{print("This is not a list.")}
}

##Function rescale100()
#' @title: rescale100
#' @description: get a rescaled vector with a potential scale from 0 to 100
#' @input: x vector
#' @input: na.rm whether to remove missing values
#' @output: a rescaled vector
#' @example: 
#' rescale100(l)
rescale100 <- function(x, xmin, xmax, na.rm = TRUE){
  x <- remove_missing(x)
  if(is.numeric(x)){
    value <- 100*((x - xmin) / (xmax - xmin))
    return(value) #@output
  }
  else{print("This is not a numeric vector.")}
}


##Function drop_lowest()
#' @title: drop_lowest
#' @description:  dropping the lowest value
#' @input: x vector
#' @input: na.rm whether to remove missing values
#' @output: a vector having dropped lowest number 
#' @example: 
#' drop_lowest(m)
drop_lowest <- function(x, na.rm = TRUE){
  x <- remove_missing(x)
  if(is.numeric(x)){
    value <- get_minimum(x)
    return(x[-(x==value)])
    }
  else{print("This is not a numeric vector.")}
}


##Function score_homework()
#' @title: score_homework
#' @description: drop the lowest number, and get the average
#' @input: x vector
#' @input: drop whether to remove lowest number
#' @input: na.rm whether to remove missing values
#' @output: the average of a vector dropping lowest number
#' @example: 
#' score_homework(n)
score_homework <- function(x, drop = TRUE, na.rm = TRUE){
  x <- remove_missing(x)
  if(is.numeric(x)){
    if(drop == TRUE){
    x <- drop_lowest(x)
    value <- get_average(x)}
    else{value <- get_average(x)}
    return(value)
  }
  else{print("This is not a numeric vector.")}
}


##Function score_quiz()
#' @title: score_quiz
#' @description: drop the lowest number, and get the average
#' @input: x vector
#' @input: drop whether to remove lowest number
#' @input: na.rm whether to remove missing values
#' @output: the average of a vector dropping lowest number
#' @example: 
#' score_quiz(o)
score_quiz <- function(x, drop = TRUE,  na.rm = TRUE){
  x <- remove_missing(x)
  if(is.numeric(x)){
    if(drop == TRUE){
      x <- drop_lowest(x)
      value <- get_average(x)}
    else{value <- get_average(x)}
    return(value) #@output
  }
  else{print("This is not a numeric vector.")}
}


##Function score_lab()
#' @title: score_lab
#' @description: calculate the lab score
#' @input: number
#' @output: the lab score
#' @example: 
#' score_lab(number)

score_lab <- function(x){
  if(is.numeric(x)){
    if(x > 12){print("This is an invalid number.")}
    else{Markvalue <- c(0,0,0,0,0,0,0,20,40,60,80,100,100)
    value = Markvalue[x+1]
    return(value)}
  }
  else{print("This is not a numeric")}
}


