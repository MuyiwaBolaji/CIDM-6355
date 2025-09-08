#define and choose the dataset
Lab8Data<- read.csv(file.choose(), header = T)
#view the top few rows in the dataset Lab8Data
head(Lab8Data)
#view the descriptive statisitics for all attributes in Lab8Data
summary(Lab8Data)
#view the structure of the dataset
str(Lab8Data)
#generate a correlation matrix for numerical attributes to see if we have highly-correlated attributes even though k-means may not be badly affected by them
cor(Lab8Data[,c(2:6)])
#set the seed to make sure you can get the same result as mine; of course you can change the seed number later
set.seed(100)
#use k-means function for clustering, which includes three parameters: data, the number of clusters and nstart;
#data: we use the columns 2-6 for clustering 
#we use 3 as the initial k, but later we can change it to any other number
#we specify nstart =100. This means that R will try 100 different random starting assignments and select the one with the lowest within cluster variation
CityCluster<-kmeans(Lab8Data[,2:6], 3, nstart = 100)
#check the clustering result 
CityCluster
#in the result, you find Cluster means, clustering vector, within cluster sum of squares by cluster(i.e the percentage of variance explained), and available components
#generate a table to see which city belongs to which cluster 
table(CityCluster$cluster, Lab8Data$Metropolitan_Area)
#display a data frame to show the number of observations in each cluster and the mean of each attribute in each cluster
data.frame(CityCluster$size, CityCluster$center)
#create a new data frame to contain clusterID snd the five attributes for each observation
CityRecords<-data.frame(CityCluster$cluster, Lab8Data[c(1:6)])
#check the first few rows of CityRecords
head(CityRecords)
#save the new dataset as a csv file 
write.csv(CityRecords, file = "CityRecords.csv")