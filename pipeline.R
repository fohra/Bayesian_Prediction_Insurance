#Sets the working directory the folder where the script is
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(e1071)
library(aaltobda)
library(rstan)
library(ggplot2)
library(dplyr)
library(tidyr)
rstan_options(auto_write = TRUE)
options(mc.cores = 1)
library(loo)
library(gridExtra)
library(rprojroot)
library(rstanarm)

#load libraries, functions and data
source("data/preprocess.R")
source("data/loo_diagnostics.R")
data <- read.csv("data/insurance.csv")
#original data 
#     *age: int
#     *sex: factor female/male
#     *bmi: num(float?)
#     *smoker: factor
#     *charges: num(float?)

#preprocessing (SIMPLE READY)
#     *separate file for preprocessing in data/preprocess.R
#     *push data into there -> get preprocessed data, a dataframe?
#     *delete children & region
#     *Check if crazy outliers(NOT YET)
#     *factors into 0,1 in smoker and sex

#Else
#     *List all of the covariates into list for the stanfit
#     *Call stanfit
#     *stancodes
#     *after that? plots? evaluation of model results
#     *arguments for running different files
#     *think about saving stan fit so no time in compilation lost!!!
#     more info here https://discourse.mc-stan.org/t/saving-and-sharing-an-rstan-model-fit/1059

data <- preprocess(data)
data
data_list <- list(N = nrow(data), age = data$age, sex=data$sex, bmi=data$bmi, smoker=data$smoker, insurance=data$charges)
data_list


#Create model [Hierarchial]
sm_hierarchial <- rstan::stan_model(file = "stan_codes/stan_hierarchial.stan")

model_hierarchial <- rstan::sampling(sm_hierarchial, data = data_list)
model_hierarchial

draws_fact_hierarchial <- rstan::extract(model_hierarchial, permuted = T)

draws_hierarchial <- as.data.frame(model_hierarchial)

par(mfrow=c(2,2))
hist(draws_fact_hierarchial$age, breaks=20)
hist(draws_fact_hierarchial$sex, breaks=20)
hist(draws_fact_hierarchial$bmi, breaks=20)
hist(draws_fact_hierarchial$smoker, breaks=20)


hist(draws_fact_hierarchial$insurance, breaks=20)

#Create model [Pooled]
sm_pooled <- rstan::stan_model(file = "stan_codes/stan_pooled.stan")

model_pooled <- rstan::sampling(sm_pooled, data = data_list)
model_pooled

draws_fact_pooled <- rstan::extract(model_pooled, permuted = T)

draws_pooled <- as.data.frame(model_pooled)

par(mfrow=c(2,2))
hist(draws_fact_pooled$age, breaks=20)
hist(draws_fact_pooled$sex, breaks=20)
hist(draws_fact_pooled$bmi, breaks=20)
hist(draws_fact_pooled$smoker, breaks=20)


hist(draws_fact_pooled$insurance)

parameter_name = 'log_lik_insurance'
loo_diagnostics(model_hierarchial, parameter_name)


