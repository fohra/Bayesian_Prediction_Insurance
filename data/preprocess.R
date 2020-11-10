preprocess <- function(data){
  #data: dataframe (age, sex, bmi, children, smoker, region, charges)
  #drop children, region
  data <- subset(data, select = -c(children, region))
  
  #change sex and smoker from factors to numerical
  data$sex <- as.numeric(data$sex) #female 1, male 2
  
  data$smoker <- as.numeric(data$smoker) #no smoking 2, smoking 1
  data$smoker[data$smoker == 2] <- 0 #no smoking 0, smoking 1
  
  return(data)
}