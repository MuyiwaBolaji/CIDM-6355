#change the value "abstain" to "n" to make the variable binomial
Lab5Train$education.spending[Lab5Train$education.spending=="abstain"]<-"n"
#develop a logistic regression model using glm function
LogModel <- glm(education.spending ~.,family = "binomial", data = Lab5Train)
#view the logisitc regression mode 
summary(LogModel)
#use the LR model to make prediction
Lab5ScoreLR <- predict(LogModel,Lab5Predict, type="response")
#view the prediction; Round all those predicted probabilitie to the third decimal place
round(Lab5ScoreLR, 3)
#check if each predicted probability is greater than 0.5( i.e with y as the predicted class)
Lab5ScoreLR>0.5
#count how many of them are predicted as y( Probability greater than 0.5)
sum(Lab5ScoreLR>0.5)