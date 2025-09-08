#define and choose the dataset
Exam2Data1<- read.csv(file.choose(), header = T)
#view the top few rows in the dataset Exam2Data1
head(Exam2Data1)
#view the descriptive statisitics for all attributes in Lab8Data
summary(Exam2Data1)
#view the structure of the dataset
str(Exam2Data1)
#generate a correlation matrix for numerical attributes to see if we have highly-correlated attributes even though k-means may not be badly affected by them
cor(Exam2Data1[,c(1:6)])
#install and use the library clustersim for data normalization
install.packages("clusterSim")
library(clusterSim)

#we normaliza the first 6 column using data.normalization function with the type=n4 meaning utilization with zero minimum
Exam2Data1[1:6]<- data.Normalization(Exam2Data1[1:6], type="n4", normalization="column")
#check if the data is normalized
summary(Exam2Data1)

#set the seed to make sure you can get the same result as mine; of course you can change the seed number later
set.seed(123)
summary(Exam2Data1)
#use hclust for hierarchial clustering;hclust requires the data in the form of a distance matrix . Do this by using dist(euclidean is the default method).
#by default, the complete linkage method is used for hclust; use the 2nd, 3rd, and the 5th columns for clustering 
clusters<- hclust(dist(Exam2Data1[, 2:3,5]))
#generate a cluster dendrogram
plot(clusters)
#cut off the dendrogram tree at the desired number of clusters using cutree
hcluster<- cutree(clusters, 3)

#: Generate a table showing the size of each cluster
cluster_sizes <- table(hcluster)

#generate a new column called hlabel to save the cluster in the dataset
Exam2Data1$hlabel<-hcluster
#use the library ggplot2
library(ggplot2)
#draw a chart to show the average quality ratings  for each cluster
ggplot(x=label, y=quality, data = Exam2Data1)
#compute the average quality for each cluster and assign a new name for the mean
#here i use two lines, but one line is ok: meanmpg<-setNames(aggregate(Lab9Data$mpg, list(Lab9Data$label), mean), c("cluster", "averagempg"))
meanquality<-aggregate(Exam2Data1$quality, list(Exam2Data1$hlabel), mean)
colnames(meanquality) <- c("cluster", "averagequality")
meanquality
#generate a bar chart to show the mean mpg for each cluster 
barplot(meanquality$averagequality,main="Average quality", names.arg=meanquality$cluster, xlab="Cluster", ylab = "Average quality")
#conduct ANOVA test
summary(aov(quality ~ factor(hlabel), data = Exam2Data1))
#save the new dataset as a csv file
#write.csv(Lab9Data, file = "Lab9Data2.csv")