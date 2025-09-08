#Define and choose Training and Prediction Datasets
Lab5Train<- read.csv(file.choose(), header = T, stringsAsFactors = T)
Lab5Predict<- read.csv(file.choose(), header = T, stringsAsFactors = T)
#view column names and dimensions of the training dataset(please notice that dash is changed to dot in R)
names(Lab5Train)
dim(Lab5Train)
#view the summary statisitcs of the training dataset
summary(Lab5Train)
#install package e1071
install.packages("e1071")
#invoke the library e1071
library(e1071)
#build a NB model using naive bayes functions and including all attributes
Lab5NB <- naiveBayes(education.spending ~., data=Lab5Train)
#view the NB Model generated and conditional probabilities
Lab5NB
#Apply the NB model to the prediction dataset
Lab5Score <- predict(Lab5NB,Lab5Predict)
#view the prediction result
Lab5Score
#show the summary statisitcs of Lab5Score
summary(Lab5Score)
#the following three rows of script help us write the prediction value of education.spending to the prediction dataset
score<-data.frame(Lab5Score)
Lab5Predict$education.spending<-Score$Lab5Score
Lab5Predict
