#define and choose the dataset
Lab10Data<-read.csv(file.choose(), header = T)
#check the structure and dimension of your data
str(Lab10Data)
dim(Lab10Data)
#only include those attributes with Yes or No; remove the first attribute and then check the dimension
Groups<-Lab10Data[2:303]
dim(Groups)
#install and use the library arules for association rule mining
install.packages("arules")
library(arules)
#to modify the dataset by removing false because we are interested in the rule that when one appears in a transaction another also appears
#Attention: there is a space in the front of "false"; you can check this in the original dataset
Groups[Groups==" false"]<-NA
#find rules with support at least 0.01, maximum of 3 items, minimum of 2 items, confidence at least 0.5; you will find that we have many rules
rules<-apriori(Groups, parameter=list(supp=0.01,minlen=2,maxlen=3,conf=0.5))
#install ans use the library arulesViz to visualize the rules
install.packages("arulesViz")
library(arulesViz)
#visualize the rule by defaults settings
plot(rules)
#to get the exact count of number of rules use length(rules)
length(rules)
#visualize the rule with confidence as shading
plot(rules, measure=c("support","lift"), shading="confidence")
#because we have too many rules, we need to trim down the rules to the ones that are more important by setting a higher support
rules2<-apriori(Groups,parameter=list(supp=0.037,minlen=2, maxlen=3, conf=0.5))
#generate a summary of all the trimmed rules
summary(rules2)
#look at and sort the rules using the inspect function
arules::inspect(sort(rules2, by = "confidence"))
#convert rules2 as a data frame 
as(rules2, "data.frame")
#write the rules in a csv file 
write(rules2, file = "rules2.csv", sep = ",", quote= TRUE, row.names =FALSE)