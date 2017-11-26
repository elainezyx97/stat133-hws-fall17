#title: clean-data-script
#description: 
#input(s): rawscores.csv
#output(s): summary.txt and cleanscores.csv

library(dplyr)
source('hw04/code/functions.R')
## importing data
rawdata <- data.frame(
    read.csv('hw04/data/rawdata/rawscores.csv',header = TRUE))

## sink summary file
sink(file = 'hw04/output/summary-rawscores.txt')
print('raw scores summary')
str(rawdata)
cat('\n')
for(i in 1:ncol(rawdata)){
  cat(names(rawdata)[i], '\n')
  print_stats(summary_stats(rawdata[ ,i]))
  cat('\n')
}
sink()

## replace NA with zero
for(i in 1:ncol(rawdata)){
  rawdata[is.na(rawdata[ ,i]), i] <-0
}

rawdata$QZ1 <- rescale100(rawdata$QZ1, xmin = 0, xmax = 12)
rawdata$QZ2 <- rescale100(rawdata$QZ2, xmin = 0, xmax = 18)
rawdata$QZ3 <- rescale100(rawdata$QZ3, xmin = 0, xmax = 20)
rawdata$QZ4 <- rescale100(rawdata$QZ4, xmin = 0, xmax = 20)
rawdata$Test1 <- rescale100(rawdata$EX1, xmin = 0, xmax = 80)
rawdata$Test2 <- rescale100(rawdata$EX2, xmin = 0, xmax = 90)


## get a new column Homework
Homework <-c()
for(i in 1:nrow(rawdata)){
  Homework[i] <- score_homework(rawdata[i, 
                                       c('HW1', 'HW2', 'HW3', 'HW4', 
                                         'HW5', 'HW6', 'HW7', 'HW8', 'HW9')])
}
rawdata$Homework <- Homework

## get a new column Quiz
Quiz <-c()
for(i in 1:nrow(rawdata)){
  Quiz[i] <- score_quiz(rawdata[i, 
                               c('QZ1', 'QZ2', 'QZ3', 'QZ4')])}
rawdata$Quiz <- Quiz

##get Overall
Overall <- c()

Lab <-c()
for(i in 1:nrow(rawdata)){
  Lab[i] <- score_lab(rawdata[i, 'ATT'])}
rawdata$Lab <- Lab

rawdata$Overall <- 0.1*rawdata$Lab + 0.3*rawdata$Homework + 0.15*rawdata$Quiz + 0.2*rawdata$Test1 + 0.25*rawdata$Test2


## get a new column,Grade, with letter grade
get_grade <- function(x){if(x >= 95) 
{x = 'A+' }
  else if(x >=90) {x = 'A' }
  else if(x >= 88) {x = 'A-' }
  else if(x >= 86) {x = 'B+' }
  else if(x >= 82) {x = 'B' }
  else if(x >= 79.5) {x = 'B-' }
  else if(x >= 77.5) {x = 'C+' }
  else if(x >= 70) {x = 'C' }
  else if(x >= 60) {x = 'C-' }
  else if(x >= 50) {x = 'D' }
  else if(x >= 0) {x = 'F' }}

for(i in 1:nrow(rawdata))
{rawdata$Grade[i] = get_grade(rawdata$Overall[i])}

cleandata<-rawdata
## summary 
file_name <- c("Test1","Test2","Homework","Quiz","Lab","Overall")

for(i in 1:length(file_name)){
  sink(file = paste('hw04/output/',file_name[i],'-stats.txt',sep = ""))
  print_stats(unlist(cleandata[file_name[i]]))
  sink()
}

## the structure of the clean scores
sink(file = 'hw04/output/summary-cleanscores.txt')
str(cleandata)
sink()

## export the clean data to a CSV file
cleandata <- data.frame(cleandata, stringsAsFactors = FALSE)
write.csv(cleandata, file = 'hw04/data/cleandata/cleanscores.csv')
















