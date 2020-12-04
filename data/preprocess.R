preprocess <- function(data){
  #data: dataframe (age, sex, bmi, children, smoker, region, charges)
  #drop children, region
  data <- subset(data, select = -c(region))
  #change sex and smoker from factors to numerical
  data$sex[data$sex == 'female'] <- as.numeric(0) 
  data$sex[data$sex == 'male'] <- as.numeric(1)
  data$sex <- as.numeric(data$sex)
  data$smoker[data$smoker == 'no'] <- as.numeric(0) 
  data$smoker[data$smoker == 'yes'] <- as.numeric(1)
  data$smoker <- as.numeric(data$smoker)
  return(data)
}
