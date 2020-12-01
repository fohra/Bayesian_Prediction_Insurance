preprocess <- function(data){
  #data: dataframe (age, sex, bmi, children, smoker, region, charges)
  #drop children, region
  #change sex and smoker from factors to numerical
  data$sex[data$sex == 'female'] <- as.numeric(0) 
  data$sex[data$sex == 'male'] <- as.numeric(1)
  data$sex <- as.numeric(data$sex)
  data$smoker[data$smoker == 'no'] <- as.numeric(0) 
  data$smoker[data$smoker == 'yes'] <- as.numeric(1)
  data$region[data$region == 'southwest'] <- as.numeric(0) 
  data$region[data$region == 'southeast'] <- as.numeric(1)
  data$region[data$region == 'northwest'] <- as.numeric(2) 
  data$region[data$region == 'northeast'] <- as.numeric(3)
  data$region <- as.numeric(data$region)
  data$smoker <- as.numeric(data$smoker)
  return(data)
}
