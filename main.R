#Sets the working directory the folder where the script is
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

#load libraries, functions and data
source("data/preprocess.R")
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

data_list <- list(N = length(data$age), age = data$age, sex=data$sex, bmi=data$bmi, smoker=data$smoker, y=data$charges)
