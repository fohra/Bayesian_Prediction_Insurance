setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library(rstan)
library(ggplot2)
library(dplyr)
library(tidyr)
rstan_options(auto_write = TRUE)
options(mc.cores = 4)
library(loo)
library(gridExtra)


#load libraries, functions and data
source("data/preprocess.R")
source("plotting_functions.R")
source("data/loo_diagnostics.R")
data <- read.csv("data/preprocess_all.csv")
#data <- preprocess(data)

###
###CHANGE THESE
###


###person 1


bmi = 30
smoker = 0
age = 25
sex = 1
children = 1

data_list <- list(N = nrow(data), age = data$age,children=data$children, sex=data$sex, bmi=data$bmi, smoker=data$smoker, y=data$charges, 
                  pred_age = age, pred_bmi=bmi, pred_smoker=smoker, pred_children=children,pred_sex=sex)

sm <- rstan::stan_model(file = "stan_codes/stan_pooled.stan")

model <- rstan::sampling(sm, data = data_list)

draws <- rstan::extract(model, permuted = T)
#charges <- data$charges[data$age<=age+2 & data$age>=age-2 & data$bmi<=bmi+5 & data$bmi>=bmi-5 &
#                  data$children==children & data$sex==sex & data$smoker==0 ]
p1 <-plot_vald(draws,data,age,bmi,children,sex,smoker) +ggtitle("person 1")

###person 2


bmi = 30
smoker = 1
age = 25
sex = 1
children = 1

data_list <- list(N = nrow(data), age = data$age,children=data$children, sex=data$sex, bmi=data$bmi, smoker=data$smoker, y=data$charges, 
                  pred_age = age, pred_bmi=bmi, pred_smoker=smoker, pred_children=children,pred_sex=sex)

sm <- rstan::stan_model(file = "stan_codes/stan_pooled.stan")

model <- rstan::sampling(sm, data = data_list)

draws <- rstan::extract(model, permuted = T)
#charges <- data$charges[data$age<=age+2 & data$age>=age-2 & data$bmi<=bmi+5 & data$bmi>=bmi-5 &
#                  data$children==children & data$sex==sex & data$smoker==0 ]
p2 <-plot_vald(draws,data,age,bmi,children,sex,smoker) +ggtitle("person 2")

###person 3


bmi = 40
smoker = 1
age = 30
sex = 1
children = 1

data_list <- list(N = nrow(data), age = data$age,children=data$children, sex=data$sex, bmi=data$bmi, smoker=data$smoker, y=data$charges, 
                  pred_age = age, pred_bmi=bmi, pred_smoker=smoker, pred_children=children,pred_sex=sex)

sm <- rstan::stan_model(file = "stan_codes/stan_pooled.stan")

model <- rstan::sampling(sm, data = data_list)

draws <- rstan::extract(model, permuted = T)
#charges <- data$charges[data$age<=age+2 & data$age>=age-2 & data$bmi<=bmi+5 & data$bmi>=bmi-5 &
#                  data$children==children & data$sex==sex & data$smoker==0 ]
p3 <-plot_vald(draws,data,age,bmi,children,sex,smoker) +ggtitle("person 3")

###person 4

bmi = 40
smoker = 0
age = 40
sex = 0
children = 0

data_list <- list(N = nrow(data), age = data$age,children=data$children, sex=data$sex, bmi=data$bmi, smoker=data$smoker, y=data$charges, 
                  pred_age = age, pred_bmi=bmi, pred_smoker=smoker, pred_children=children,pred_sex=sex)

sm <- rstan::stan_model(file = "stan_codes/stan_pooled.stan")

model <- rstan::sampling(sm, data = data_list)

draws <- rstan::extract(model, permuted = T)
#charges <- data$charges[data$age<=age+2 & data$age>=age-2 & data$bmi<=bmi+5 & data$bmi>=bmi-5 &
#                  data$children==children & data$sex==sex & data$smoker==0 ]
p4 <-plot_vald(draws,data,age,bmi,children,sex,smoker) +ggtitle("person 4")


### person 5

bmi = 30
smoker = 0
age = 40
sex = 0
children = 4

data_list <- list(N = nrow(data), age = data$age,children=data$children, sex=data$sex, bmi=data$bmi, smoker=data$smoker, y=data$charges, 
                  pred_age = age, pred_bmi=bmi, pred_smoker=smoker, pred_children=children,pred_sex=sex)

sm <- rstan::stan_model(file = "stan_codes/stan_pooled.stan")

model <- rstan::sampling(sm, data = data_list)

draws <- rstan::extract(model, permuted = T)
#charges <- data$charges[data$age<=age+2 & data$age>=age-2 & data$bmi<=bmi+5 & data$bmi>=bmi-5 &
#                  data$children==children & data$sex==sex & data$smoker==0 ]
p5 <-plot_vald(draws,data,age,bmi,children,sex,smoker) +ggtitle("person 5")


