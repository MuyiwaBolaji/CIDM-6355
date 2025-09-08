#define and choose the dataset
Lab9Data<- read.csv(file.choose(), header = T)
#show summary statistic of the data and check the unit of each attribute 
summary(Lab9Data)
#normalize the three attribute to the range 0-1
Lab9Data$cylinders<-(Lab9Data$cylinders-min(Lab9Data$cylinders))/(max(Lab9Data$cylinders)-min(Lab9Data$cylinders))
Lab9Data$cubicinches<-(Lab9Data$cubicinches-min(Lab9Data$cubicinches))/(max(Lab9Data$cubicinches)-min(Lab9Data$cubicinches))
Lab9Data$weightlbs<-(Lab9Data$weightlbs-min(Lab9Data$weightlbs))/(max(Lab9Data$weightlbs)-min(Lab9Data$weightlbs))
#show summary statistics of the normalized data
summary(Lab9Data)
#use hclust for hierarchial clustering;hclust requires the data in the form of a distance matrix . Do this by using dist(euclidean is the default method).
#by default, the complete linkage method is used for hclust; use the 2nd, 3rd, and the 5th columns for clustering 
clusters<- hclust(dist(Lab9Data[, 2:3,5]))
#generate a cluster dendrogram
plot(clusters)
#cut off the dendrogram tree at the desired number of clusters using cutree
clusterCut<- cutree(clusters, 3)
#generate a new column called label to save the cluster in the dataset
Lab9Data$label<-clusterCut
#use the library ggplot2
library(ggplot2)
#draw a chart to show the distribution of mpg for each cluster
qplot(x=label, y=mpg, data = Lab9Data)
#compute the average mpg for each cluster and assign a new name for the mean
#here i use two lines, but one line is ok: meanmpg<-setNames(aggregate(Lab9Data$mpg, list(Lab9Data$label), mean), c("cluster", "averagempg"))
meanmpg<-aggregate(Lab9Data$mpg, list(Lab9Data$label), mean)
colnames(meanmpg) <- c("cluster", "averagempg")
meanmpg
#generate a bar chart to show the mean mpg for each cluster 
barplot(meanmpg$averagempg,main="Average MPG", names.arg=meanmpg$cluster, xlab="cluster")
#conduct ANOVA test
summary(aov(mpg ~ factor(label), data = Lab9Data))
#save the new dataset as a csv file
write.csv(Lab9Data, file = "Lab9Data2.csv")
