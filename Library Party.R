#use the library party to decison tree
#define and choose Training and Prediction dataset
Lab4Train<- read.csv(file.choose(), header = T, stringsAsFactors = TRUE)
Lab4Predict<- read.csv(file.choose(), header = T, stringsAsFactors = TRUE)
#view column names and dimentions of the training dataset
names(Lab4Train)
dim(Lab4Train)
#view the summary statistics of the training dataset
summary(Lab4Train)
#attach the training dataset for ease of writing and maintening code
attach(Lab4Train)
#install the Library party for the decision treee
install.packages("party")
#invoke the needed library
library("party")
#building decision tree model using rpart function
#species_name is your target attribute, use ~ to connect the four predicting attributes 
Lab4Tree2<-ctree(Species_name ~ Petal_width + Petal_length + Sepal_width + Sepal_length,data=Lab4Train)
#examine the properties of the decision tree model created 
Lab4Tree2
#generate a decision tree graph
plot(Lab4Tree2)
#Apply the decision tree model to the prediction dataset to generate the value of target attribute in the prediction dataset
Lab4Score2<- predict(Lab4Tree2,Lab4Predict)
#view the predictions
Lab4Score2