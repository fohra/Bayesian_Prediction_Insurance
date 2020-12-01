
library(e1071)
library(ggplot2)
data <- read.csv("insurance.csv")

head(data)

n <- length(data$age)

hist(data$age)

#hist(data$sex)

hist(data$bmi)

hist(data$children)

#hist(data$smoker)
#hist(data$region)

hist(data$charges)


mean(data$age)
mean(data$bmi)
mean(data$children)
mean(data$charges)

var(data$age)
var(data$bmi)
var(data$children)
var(data$charges)

skewness(data$age)
skewness(data$bmi)
skewness(data$children)
skewness(data$charges)

kurtosis(data$age)
kurtosis(data$bmi)
kurtosis(data$children)
kurtosis(data$charges)

table(data$smoker)
table(data$region)
table(data$sex)

tab <- table(data$age)
plot(tab)

#load libraries, functions and data
source("data/preprocess.R")
data <- read.csv("data/insurance.csv")
data <- preprocess(data)

data <- read.csv("data/insurance.csv")
data<- matrix(c(data$age,data$bmi,data$children,data$charges,data$bmi),ncol = 5)

datap <- read.csv("data/insurance.csv")
datap <-  preprocess(datap)
cormat <- round(cor(data),2)

library(reshape2)
ggplot(data = melt(cormat), aes(Var2, Var1, fill = value))+
  geom_tile(color = "white")+
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", 
                       midpoint = 0, limit = c(-1,1), space = "Lab", 
                       name="Pearson\nCorrelation") +
  theme_minimal()+ 
  theme(axis.text.x = element_text(angle = 45, vjust = 1, 
                                   size = 12, hjust = 1))+
  coord_fixed()

