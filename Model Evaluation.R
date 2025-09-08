#Model Evaluation in R usidng Logisitc Regression Model as an example

#loading required libraries
library("e1071")
library("caret")
#set random seed to make the sampling reproducible
set.seed(123)
smp_size<- floor(0.7 * nrow(Lab6Data2))
train_ind <- sample(seq_len(nrow(Lab6Data2)), size = smp_size)
train <- Lab6Data2[train_ind, ]
test <- Lab6Data2[-train_ind, ]
#check the ration of train set
nrow(train) /nrow(Lab6Data2)
#build a logistic regression model using the train set
LRmodel<- glm(Phone_sale ~., family = "binomial", train)
#apply the model to the test set; probabilities are generated 
LRp<- predict(LRmodel, test, type = "response")
#check the summary of those proabilities
summary(LRp)
#because the probabilities are quite small, we reduce the threshold to 0.2
LRpredict<- ifelse(LRp > 0.20, 1, 0)
#generate a simple confusion matrix using the table function
table(LRpredict, test[["Phone_sale"]])


#alternatively we can use the confusion matrix functions to get more details 
#check the type of both LRpredict and phone_sale
typeof(LRpredict)
typeof(test[["Phone_sale"]])
#the confusion matrix function requires factors with the same level
LRp_class <- as.factor(LRpredict)
confusionMatrix(LRp_class, as.factor(test[["Phone_sale"]]))