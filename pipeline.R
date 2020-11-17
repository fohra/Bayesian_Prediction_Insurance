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
data <- preprocess(data)

#Else
#     *stancodes
#     *after that? plots? evaluation of model results


#########################
######### MAIN ##########
#########################

main <- function(data, model_path, test=FALSE){
  #Awful if-else statements included so that fast test run can be run
  if (test){
    data_list <- list(N = nrow(data), age = data$age, sex=data$sex, bmi=data$bmi, smoker=data$smoker, y=data$charges, xpred = 25)
  }
  else{
    data_list <- list(N = nrow(data), age = data$age, sex=data$sex, bmi=data$bmi, smoker=data$smoker, insurance=data$charges)
  }
  
  #Create model 
  sm <- rstan::stan_model(file = model_path)
  
  model <- rstan::sampling(sm, data = data_list)
  print(model)
  
  draws <- rstan::extract(model, permuted = T)
  
  if (test){
    par(mfrow=c(2,2))
    hist(draws$alpha, breaks=20)
    hist(draws$beta, breaks=20)
    hist(draws$sigma, breaks=20)
    hist(draws$mu, breaks=20)
    
    par(mfrow=c(1,1))
    hist(draws$ypred, breaks=20)
  }
  
  else{
    par(mfrow=c(2,2))
    hist(draws$age, breaks=20)
    hist(draws$sex, breaks=20)
    hist(draws$bmi, breaks=20)
    hist(draws$smoker, breaks=20)
    
    par(mfrow=c(1,1))
    hist(draws$insurance, breaks=20)
  }
  
  parameter_name = 'log_lik_insurance'
  loo_diagnostics(model, parameter_name)
}


hopo <- main(data, "stan_codes/stan_test.stan", TRUE)

main(data, "stan_codes/stan_hierarchial.stan")

main(data, "stan_codes/stan_pooled.stan")
