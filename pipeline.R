#Sets the working directory the folder where the script is
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(e1071)
library(aaltobda)
library(rstan)
library(ggplot2)
library(dplyr)
library(tidyr)
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())
library(loo)


#load libraries, functions and data
source("data/preprocess.R")
source("data/loo_diagnostics.R")
data <- read.csv("data/insurance.csv")
data <- preprocess(data)


#########################
######### MAIN ##########
#########################

main <- function(data, model_path, test=FALSE, lin_reg=FALSE, iter=2000, warm_up = floor(iter/2), a_delta = 0.8){
  #Awful if-else statements included so that fast test run can be run
  if (test){
    data_list <- list(N = nrow(data), age = data$age, sex=data$sex, bmi=data$bmi, smoker=data$smoker, y=data$charges, xpred = 25)
  }
  else if (lin_reg){
    data_list <- list(N = nrow(data), age = data$age, sex=data$sex, bmi=data$bmi, smoker=data$smoker, y=data$charges, 
                      pred_age = 25, pred_sex=1, pred_bmi=20, pred_smoker=1)
  }
  else{
    data_list <- list(N = nrow(data), age = data$age, sex=data$sex, bmi=data$bmi, smoker=data$smoker, insurance=data$charges)
  }
  
  #Create model 
  sm <- rstan::stan_model(file = model_path)
  
  model <- rstan::sampling(sm, data = data_list, iter = iter, warmup = warm_up, control = list(adapt_delta = a_delta))
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
  else if (lin_reg){
    par(mfrow=c(2,3))
    hist(draws$alpha, breaks=20)
    hist(draws$beta_age, breaks=20)
    #hist(draws$beta_sex, breaks=20)
    hist(draws$beta_bmi, breaks=20)
    hist(draws$beta_smoker, breaks=20)
    hist(draws$sigma, breaks=20)
    
    par(mfrow=c(1,2))
    hist(draws$mu, breaks=20)
    hist(draws$ypred, breaks=20)
    parameter_name = 'log_lik_y'
    loo_diagnostics(model, parameter_name)
  }
  else{
    par(mfrow=c(2,2))
    hist(draws$age, breaks=20)
    hist(draws$sex, breaks=20)
    hist(draws$bmi, breaks=20)
    hist(draws$smoker, breaks=20)
    
    par(mfrow=c(1,1))
    hist(draws$insurance, breaks=20)
    
    parameter_name = 'log_lik_insurance'
    loo_diagnostics(model, parameter_name)
  }
  return(model)
}

#########################
####### LIN_REG #########
#########################
model1 <- main(data, "stan_codes/stan_lin_reg_hierarchial.stan", lin_reg = TRUE, iter = 12000, warm_up = 2000, a_delta = 0.99)
model2 <- main(data, "stan_codes/stan_lin_reg_pooled.stan", lin_reg = TRUE)
model3 <- main(data, "stan_codes/hie_not_sex.stan", lin_reg = TRUE)

monitor(model3)

#########################
#### HIE & POOLED #######
#########################
main(data, "stan_codes/stan_hierarchial.stan")

main(data, "stan_codes/stan_pooled.stan")


#########################
######### TEST ##########
#########################
main(data, "stan_codes/stan_test.stan", TRUE)
