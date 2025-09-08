#locate the data file manually; of course you can use the absolute path or put your datafile in the R directory
Lab3<- read.csv(file.choose(), header=T)
#view the structure of the dataset; the R practice shows you that R has five main data types. In the result, you will find the data structure is data frame.
str(Lab3)
#Replace the commas in the column 6 using the gsub() function (for details please check http://www.endmemo.com/program/R/gsub.php)
Column6=gsub(",","", Lab3$MedianHouseholdIncome)
Lab3$MedianHouseholdIncome<- as.numeric(Column6)
#review the structure of the new dataset to check if the data type of column 6 changes 
str(Lab3)
#review the summary of the dataset; you will find Column 4 has many missing values (NA)
summary(Lab3)
#drop the records with the missing values using the function na.omit (and name the new dataset as Lab3_2)
Lab3_2<- na.omit(Lab3)
#review the summary of the new dataset;you will find column 4 has no missing values now
summary(Lab3_2)
#view the duplicated records
Lab3_2[duplicated(Lab3_2),]
#remove duplicated records and save the datasets without duplicates in a new data file Lab3_3
Lab3_3<- Lab3_2[!duplicated(Lab3_2), ]
#view the structure of Lab3_3
str(Lab3_3)
#replace letters in Column 1 by zero using the gsub() function
Column1=gsub("[A-Z]", "0", Lab3_3$RegionID)
Lab3_3$RegionID<- Column1
#view the structure of Lab3_3
str(Lab3_3)
#save the cleaned data in your local computer( you can find it in your R default folder)
write.csv(Lab3_3, file = "Lab3_3.csv")
#import zipcode file (US.txt) that you downloaded from the WTCLASS using the read.delim
zipcode<- read.delim(file.choose() ,header = F)
#view the head of this file and you will find that variable are not named
head(zipcode)
#rename all the variables(you can find those names from the readme.txt in the zipped file)
names(zipcode)<- c("country_code", "postal_code", "place", "state", "st", "county",
                   "countycode", "community", "communitycode", "latitude", "longitude", "accuracy")
#recheck names of all the variables
names(zipcode)
#view the structure of zipcode
str(zipcode)
#postal_code is integer, but RegionID is character, so convert one of them to be consistent; here, we convert postal_code to be character using as.character()
zipcode$postal_code<- as.character(zipcode$postal_code)
#check whether postal_code is converted to be character
str(zipcode)
#there are many methods to join two dataframes; here we are going to the join() function in the dplyr library
install.packages("dplyr")
library(dplyr)
#use inner join to merge the two dataframes and name the merged file as Lab3_4
Lab3_4<- inner_join(Lab3_3, zipcode, by=c("RegionID"="postal_code"))
#view the first six rows of the new dataframe
head(Lab3_4)
#check the structure of the combined dataset
str(Lab3_4)
#save the combined data in your local computer
write.csv(Lab3_4, file = "Lab3_4.csv")