#define and choose Training and Prediction dataset
Lab4Train<- read.csv(file.choose(), header = T)
Lab4Predict<- read.csv(file.choose(), header = T)
#view column names and dimentions of the training dataset
names(Lab4Train)
dim(Lab4Train)
#view the summary statistics of the training dataset
summary(Lab4Train)
#attach the training dataset for ease of writing and maintening code
attach(Lab4Train)
#install the Library rpart for the decision treee
install.packages("rpart")
#invoke the needed library
library(rpart)
#building decision tree model using rpart function
#species_name is your target attribute, use ~ to connect the four predicting attributes and then use method ="class".
Lab4Tree<- rpart(Species_name ~ Petal_width + Petal_length + Sepal_width + Sepal_length, method="class")
#examine the properties of the decision tree model created using the rpart function
summary(Lab4Tree)
#install another library to generate the decision tree graph
install.packages("rpart.plot")
library(rpart.plot)
prp(Lab4Tree, extra=4 , faclen=0, varlen=0)
#Apply the decision tree model to the prediction dataset to generate the value of target attribute in the prediction dataset
Lab4Score<- predict(Lab4Tree,Lab4Predict)
#view the predictions
Lab4Score