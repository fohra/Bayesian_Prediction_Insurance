#Sets the working directory the folder where the script is
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

#load libraries, functions and data
library(ggplot2)
library(gridExtra)
source("data/preprocess.R")
data <- read.csv("data/insurance.csv")

data2 <- preprocess(data)

summary(data2)
pairs(data2)


plot1 <- qplot(data2$age, data = data, geom = "density", color = sex, linetype = sex)
plot2 <- qplot(data2$bmi, data = data, geom = "density", color = sex, linetype = sex)
plot3 <- qplot(data2$smoker, data = data, geom = "density", color = sex, linetype = sex)
plot4 <- qplot(data2$charges, data = data, geom = "density", color = sex, linetype = sex)

grid.arrange(plot1, plot2, plot3, plot4)

plot1 <- qplot(data2$age, data = data, geom = "density", color = smoker, linetype = smoker)
plot2 <- qplot(data2$sex, data = data, geom = "density", color = smoker, linetype = smoker)
plot3 <- qplot(data2$bmi, data = data, geom = "density", color = smoker, linetype = smoker)
plot4 <- qplot(data2$charges, data = data, geom = "density", color = smoker, linetype = smoker)

grid.arrange(plot1, plot2, plot3, plot4)
