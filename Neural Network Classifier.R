#define and choose the dataset
Lab6Data<- read.csv(file.choose(), header = T)
#view the dimensions of the dataset
dim(Lab6Data)
#show the top few rows to see the view of the data
head(Lab6Data)
#remove the first column id
Lab6Data[1]<-NULL
#install library dplyr
install.packages('dplyr')
library(dplyr)
library(reshape2)
#generate correlation coefficient matrix
Lab6cor<-as.matrix(cor(Lab6Data))
#melt correlation coefficient matrix to an arrange and sort by its absolute value 
#based on this arrange, you can find the largest correlation coefficients
Lab6cormelt <- arrange(melt(Lab6cor), -abs(value))
Lab6cormelt
#assign the self-correlation and upper part of the correlation matrix as zero
Lab6cor [! lower.tri(Lab6cor)] <- 0
#remove highly-correlated variables, with correlation coefficients greater than 0.8
Lab6Data2<- Lab6Data[, !apply(Lab6cor, 2, function(x) any(abs(x) > 0.8))]
#check the attribute names of the new and clean dataset
names(Lab6Data2)
#install the package nnet for neural network 
install.packages("nnet")
library(nnet)
#set the seed to make sure you can get the same result as mine; of course, you can change the seed number later
set.seed(1000)
#build a neural network model using phone_sale as target attribute and other attribute as predictor attribute
#the size parameter indicates the numbers of nodes we wish to use the hidden layer
#the maxit parameter indicates the maximum iterations
Lab6Net <- nnet(Phone_sale ~. , data=Lab6Data2, size=8, maxit=10000)
#install the packages NeuralNetTools
install.packages("NeuralNetTools")
library(NeuralNetTools)
#plot the neural network model
plotnet(Lab6Net)