#title: data preparation
#description: to create a csv data file nba2017-teams.csv that will contain
#             the required variables to be used in the ranking analysis
#input(s): nba2017-roster.csv    nba2017-stats.csv
#output(s): nba2017-teams.csv

library(dplyr)
library(ggplot2)
nba2017_stats<-read.csv('C:/Users/mycpu/Desktop/about_work/about_work/work/begin/work8/hw03/data/nba2017-stats.csv',header = TRUE)
nba2017_stats<-mutate(nba2017_stats,missed_fg=field_goals_atts-field_goals_made)
nba2017_stats<-mutate(nba2017_stats,missed_ft=points1_atts-points1_made)
nba2017_stats<-mutate(nba2017_stats,points=3*points3_made+2*points2_made+points1_made)
nba2017_stats<-mutate(nba2017_stats,rebounds=off_rebounds+def_rebounds)
nba2017_stats<-mutate(nba2017_stats,efficiency=(points+rebounds+assists+steals+blocks-missed_fg
                                                -missed_ft - turnovers)/games_played)

sink("C:/Users/mycpu/Desktop/about_work/about_work/work/begin/work8/hw03/output/efficiency-summary.txt")
summary(nba2017_stats$efficiency)
sink()

nba2017_roster<-read.csv('C:/Users/mycpu/Desktop/about_work/about_work/work/begin/work8/hw03/data/nba2017-roster.csv',header = TRUE)
sink("C:/Users/mycpu/Desktop/about_work/about_work/work/begin/work8/hw03/data/nba2017-roster-dictionary.md")
write.table(
  format(nba2017_roster, digits=2), "",
  sep="|", row.names=F, col.names=T, quote=F, eol="|\n")
sink()

sink("C:/Users/mycpu/Desktop/about_work/about_work/work/begin/work8/hw03/data/nba2017-stats-dictionary.md")
write.table(
  format(nba2017_stats, digits=2), "",
  sep="|", row.names=F, col.names=T, quote=F, eol="|\n")
sink()

join_data<-merge(nba2017_stats,nba2017_roster)
labels<-data.frame(table(join_data$team))

n<-length(labels$Var1)
tempdata<-data.frame(team='',experience='',salary='',points3='',points2='',free_throws='',
                     points='',off_rebounds='',def_rebounds='',assists='',steals='',blocks='',
                     turnovers='',fouls='',efficiency='')

teams<-NULL
for(i in 1:n){
  temp<-subset(join_data,join_data$team==labels$Var1[i])
  tempdata$team=labels$Var1[i]
  tempdata$experience=round(sum(temp$experience),2)
  tempdata$salary=round(sum(temp$salary)/1000000,2)
  tempdata$points3=sum(temp$points3_made)
  tempdata$points2=sum(temp$points2_made)
  tempdata$free_throws=sum(temp$points1_made)
  tempdata$points=sum(temp$points)
  tempdata$off_rebounds=sum(temp$off_rebounds)
  tempdata$def_rebounds=sum(temp$def_rebounds)
  tempdata$assists=sum(temp$assists)
  tempdata$steals=sum(temp$steals)
  tempdata$blocks=sum(temp$blocks)
  tempdata$turnovers=sum(temp$turnovers)
  tempdata$fouls=sum(temp$fouls)
  tempdata$efficiency=sum(temp$efficiency)
  teams<-rbind(teams,tempdata)
  tempdata<-data.frame(team='',experience='',salary='',points3='',points2='',free_throws='',
                       points='',off_rebounds='',def_rebounds='',assists='',steals='',blocks='',
                       turnovers='',fouls='',efficiency='')
}


sink("C:/Users/mycpu/Desktop/about_work/about_work/work/begin/work8/hw03/output/teams-summary.txt ")
summary(teams)
sink()

write.csv(teams,file ="C:/Users/mycpu/Desktop/about_work/about_work/work/begin/work8/hw03/data/nba2017-teams.csv ")
teams$team<-as.character(teams$team)

stars(teams[ ,-1], labels = teams$team)

ggplot(data = teams, mapping = aes(x = experience, y = salary)) + geom_point()+geom_text(aes(label=team), size=3)

