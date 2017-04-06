############################
##### Machine learning #####
############################

### three problems of machine learning: 1) classification 2) regression 3) clustering
# 1) classification: unseen data ---classifier--> class (qualitative output, predifined classes)
# 2) regression: predictors ---regression function---> response (quantitative output, previous input-output obs.)
# 3) clustering: grouping similar objects.

# performance measures
#1) classification: confusion matrix, accuracy ratio (TP+TN)/(TP+TN+FP+FN), percision ratio TP/(TP+FP), recall ratio TP/(TP+FN)
#2) regression: Root Mean Squared Error (RMSE) = sqrt( 1/N * sum(y_i - yhat_i)^2 )
    #ross-validation: for classification and regression, using trian and test datasets, by folding dataset and rotating the test dataset
#3) clustering: [high] similarity within clusters = within sum of squares & diameter, [high] similarity between clusters = between sum of squares & intercluster distance
    #Dunn index: minimum intercluster distance/maximum diameter


km_data <- kmean(data,2) #2 is number of clusters
plot(data, col = km_data$cluster) #for two var dataset??
points(km_data$centers, pch = 22, bg = c(1,2), cex = 2) #pch=22 adds filled square points, bg is colors of the points, cex is the size
km_data$centers #clusters' centroids, which are kind of like the centers of each cluster.
km_seeds$tot.withinss/km_seeds$betweenss #available after kmean(): tot.withinss = within sum of squares, betweenss = between cluster sum of squares
table(km_data$cluster, data$var) #compare clusters and actual data

# Recursive partitioning (a.k.a. decision tree)
library("rpart")
tree <- rpart(y ~ x1 + x2 + x3 + x4 + x5, data = dataframe, method = "class") #supervised learning. y is the outcome variable in the data, which is predicted by all the x's
unseen <- data.frame(x1 = c(3,3), x2 = c(4,3), x3 = c(1,7), x4 = c(4,6)) #dataset that we want to predict
pred <- predict(tree, unseen, type = "class")
table(dataframe$y, pred)

# reshuffling and sampling
n <- nrow(data)
shuffled_data <- data[sample(n),]
sample50 <- data[sample(n*0.5),]
#cross-validation or multifold sampling for train and test in clustering
accs <- rep(0,5)
for (i in 1:5) {
  indices <- (((i-1)*round((1/5)*nrow(suffled_data)))+1):(i*round((1/5)*nrow(shuffled_data)))
  train <- shuffled[-indices,]
  test <- shuffled_data[indices,]
  tree <- rpart(y ~ ., train, method = "class")
  pred <- predict(tree, test, type = "class")
  conf <- table(test$outcomevar, pred)
  accs[i] <- sum(diag(conf))/sum(conf)
}
mean(accs) #This estimate will be a more robust measure of your accuracy. It will be less susceptible to the randomness of splitting the dataset.

