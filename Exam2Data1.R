#define and choose the dataset
Exam2Data1<- read.csv(file.choose(), header = T)
#view the top few rows in the dataset Exam2Data1
head(Exam2Data1)
#view the descriptive statisitics for all attributes in Lab8Data
summary(Exam2Data1)
#view the structure of the dataset
str(Exam2Data1)
#generate a correlation matrix for numerical attributes to see if we have highly-correlated attributes even though k-means may not be badly affected by them
cor(Exam2Data1[,c(2:6)])

#normalize the chemical attribute to the range 0-1
#Exam2Data1$fixed_acidity<-(Exam2Data1$fixed_acidity-min(Exam2Data1$fixed_acidity))/(max(Exam2Data1$fixed_acidity)-min(Exam2Data1$fixed_acidity))
#Exam2Data1$residual_sugar<-(Exam2Data1$residual_sugar-min(Exam2Data1$residual_sugar))/(max(Exam2Data1$residual_sugar)-min(Exam2Data1$residual_sugar))
#Exam2Data1$total_sulfur_dioxide<-(Exam2Data1$total_sulfur_dioxide-min(Exam2Data1$total_sulfur_dioxide))/(max(Exam2Data1$total_sulfur_dioxide)-min(Exam2Data1$total_sulfur_dioxide))
#Exam2Data1$density<-(Exam2Data1$density-min(Exam2Data1$density))/(max(Exam2Data1$density)-min(Exam2Data1$density))
#Exam2Data1$pH<-(Exam2Data1$pH-min(Exam2Data1$pH))/(max(Exam2Data1$pH)-min(Exam2Data1$pH))
#Exam2Data1$alcohol<-(Exam2Data1$alcohol-min(Exam2Data1$alcohol))/(max(Exam2Data1$alcohol)-min(Exam2Data1$alcohol))

#install and use the library clustersim for data normalization
install.packages("clusterSim")
library(clusterSim)

#we normaliza the first 6 column using data.normalization function with the type=n4 meaning utilization with zero minimum
Exam2Data1[1:6]<- data.Normalization(Exam2Data1[1:6], type="n4", normalization="column")
#check if the data is normalized
summary(Exam2Data1)

#set the seed to make sure you can get the same result as mine; of course you can change the seed number later
set.seed(123)

#use k-means function for clustering, which includes six parameters: data, the number of clusters and nstart;
#data: we use the columns 1-6 for clustering 
#we use 3 as the initial k, but later we can change it to any other number
#we specify nstart =100. This means that R will try 100 different random starting assignments and select the one with the lowest within cluster variation
kcluster<-kmeans(Exam2Data1[,1:6], 3, nstart = 100)
#check the clustering result 
kcluster
#in the result, you find Cluster means, clustering vector, within cluster sum of squares by cluster(i.e the percentage of variance explained), and available components
#generate a table to see which parameters belongs to which cluster 
table(kcluster$cluster, Exam2Data1$quality)
#display a data frame to show the number of observations in each cluster and the mean of each attribute in each cluster
data.frame(kcluster$size, kcluster$center)
#Generate a new column called klabel to save the cluster in the dataset
Exam2Data1$klabel <- kcluster$cluster
#Perform Anova analysis
summary(aov(quality ~ factor(klabel), data = Exam2Data1))

