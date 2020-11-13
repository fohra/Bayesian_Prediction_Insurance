data {
  int<lower=0> N; // number of data points
  vector[N] age; // age of person
  vector[N] sex; // female 0, male 1
  vector[N] bmi; //body mass index
  vector[N] smoker; // non-smoker 0, smoker 1
  vector[N] insurance; // insurance for person
}

parameters {
  real theta_age; //hierarchial prior mu for age
  real <lower=0> sigma_age ; //hierarchial prior sigma for age
  
  real theta_sex; //hierarchial prior mu for sex
  real <lower=0> sigma_sex ; //hierarchial prior sigma for sex
  
  real theta_bmi; //hierarchial prior mu for bmi
  real <lower=0> sigma_bmi; //hierarchial prior sigma for bmi
  
  real theta_smoker; //hierarchial prior mu for smoker
  real <lower=0> sigma_smoker; //hierarchial prior sigma for smoker
  
  real theta_insurance; //hierarchial prior mu for insurance
  real <lower=0> sigma_insurance; //hierarchial prior sigma for insurance
}

model {
  //y ~ normal(mu, sigma);
  theta_age ~ normal(100 , 50);
  sigma_age ~ cauchy(0, 40);
  
  theta_sex ~ normal(100 , 50);
  sigma_sex ~ cauchy(0, 40);
  
  theta_bmi ~ normal(100 , 50);
  sigma_bmi ~ cauchy(0, 40);
  
  theta_smoker ~ normal(100 , 50);
  sigma_smoker ~ cauchy(0, 40);
  
  theta_insurance ~ normal(100 , 50);
  sigma_insurance ~ cauchy(0, 40);
  
  age ~ normal ( theta_age, sigma_age);
  sex ~ normal ( theta_sex, sigma_sex);
  bmi ~ normal ( theta_bmi, sigma_bmi);
  smoker ~ normal ( theta_smoker, sigma_smoker);
  insurance ~ normal ( theta_insurance, sigma_insurance);
}

generated quantities {
  real age_pred;
  real sex_pred;
  real bmi_pred;
  real smoker_pred;
  real insurance_pred;
  
  age_pred = normal_rng ( theta_age , sigma_age);
  sex_pred = normal_rng ( theta_sex , sigma_sex);
  bmi_pred = normal_rng ( theta_bmi , sigma_bmi);
  smoker_pred = normal_rng ( theta_smoker , sigma_smoker);
  insurance_pred = normal_rng ( theta_insurance , sigma_insurance);
}
