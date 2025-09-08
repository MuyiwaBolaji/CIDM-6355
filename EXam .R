#import training and prediction datasets
Exam1<-read.csv(file.choose(), header = T, stringsAsFactors = T)
Exam1_predict<-read.csv(file.choose(), header = T, stringsAsFactors = T)
#Check the structure of your dataset using str()
str(Exam1)
str(Exam1_predict)
#only select those records with US in the attribute currency
Exam1_2<-Exam1[Exam1$Currency!='GBP',]
#check whether GBP records are removed and missing data issues 
summary(Exam1_2)
str(Exam1_2)
#remove the attribute, currency, with only one level
Exam1New <-subset(Exam1_2, select=-Currency)
#check whether the attribute is removed
str(Exam1New)
#replace the missing data in OpenPrice using the minimal of OpenPrice
Exam1New$OpenPrice[which(is.na(Exam1New$OpenPrice))]<-min(Exam1New$OpenPrice,na.rm = T)
#check if missing values are replaced 
summary(Exam1New)


####Decision Tree###########

install.packages("party")
#invoke the needed library
library("party")
#building decision tree model using rpart function
#species_name is your target attribute, use ~ to connect the four predicting attributes

DT<-ctree(Competitive ~.,data=Exam1New)
#examine the properties of the decision tree model created 
DT
#generate a decision tree graph
plot(DT)
#Apply the decision tree model to the prediction dataset to generate the value of target attribute in the prediction dataset
R_DT<- predict(DT,Exam1_predict)
summary(R_DT)

#Naives Bayesian Model##########

#install package e1071
install.packages("e1071")
#invoke the library e1071
library(e1071)
#store model in NB
NB<- naiveBayes(Competitive ~.,data = Exam1)
#view the Naive Bayes Model generated and conditional probabilities
NB
#apply the model for prediction and store it in R_NB
R_NB<- predict(NB, Exam1_predict)
#view the prediction result 
R_NB
#show the summary statistics of R_NB
summary(R_NB)



#####Logistic Regression Model######
#develop a logistic regression model using glm function
LR <- glm(Competitive ~.,family = "binomial", data = Exam1)
#view the logisitc regression mode 
summary(LR)
#use the LR model to make prediction
R_LRP <- predict(LR,Exam1_predict, type="response")
#view the prediction; Round all those predicted probabilitie to the third decimal place
#round(R_LRP, 3)

#Convert probabilities to prediction class and then convert it to a factor 
R_LR<-as.factor(ifelse(R_LRP > 0.5, "yes","no"))
#many auction are predicted to attract bid
summary(R_LR)
#sum(R_LR)



###Neutral Network########
#install library dplyr
install.packages('dplyr')
library(dplyr)
library(reshape2)
#install the package nnet for neural network 
install.packages("nnet")
library(nnet)
#set the seed to make sure you can get the same result as mine; of course, you can change the seed number later
set.seed(1000)
#build a neural network model using phone_sale as target attribute and other attribute as predictor attribute
#the size parameter indicates the numbers of nodes we wish to use the hidden layer
#the maxit parameter indicates the maximum iterations
#Building a neural network
NN<-nnet(Competitive ~. , data=Exam1New, size=8, maxit=10000)
#install the packages NeuralNetTools
install.packages("NeuralNetTools")
library(NeuralNetTools)
#apply the model for prediction and store it in R_NNP
R_NNP<-predict(NN, Exam1_predict)
#convert probabilities to predictions class and then convert it to a factor
R_NN<- as.factor(ifelse(R_NNP > 0.5, "yes", "no"))
#plot the neural network model
plotnet(NN)
summary(NN)


#combine all the prediction results 
#convert all the predictions to vector and then combine all of them using rbind
R_Predict <-rbind(as.vector(R_DT), as.vector(R_NB),as.vector(R_LR), as.vector(R_NN))
#Transpose the combination and them convert it to a data frame 
R_DF<-as.data.frame(t(R_Predict))
#rename all the columns
colnames (R_DF) <-c("R_DT", "R_NB", "R_LR", "R_NN")
#write R_DF to a csv file 
write.csv(R_DF,"R_DF.csv")