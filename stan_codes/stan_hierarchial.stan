data {
  int<lower=0> N; // number of data points
  vector[N] age; // age of person
  vector[N] sex; // female 0, male 1
  vector[N] bmi; //body mass index
  vector[N] smoker; // non-smoker 0, smoker 1
  vector[N] insurance; // insurance for person
  //real xpred; //predict based on age
}

parameters {
  //real alpha;
  //real beta;
  //real<lower=0> sigma
  
  real mu_age; // hyperprior mu for age
  real <lower=0> tau_age;//hyperprior tau for age
  real theta_age; //hierarchial prior mu for age
  real <lower=0> sigma_age ; //hierarchial prior sigma for age
  
  real mu_sex; // hyperprior mu for sex
  real <lower=0> tau_sex;//hyperprior tau for sex
  real theta_sex; //hierarchial prior mu for sex
  real <lower=0> sigma_sex ; //hierarchial prior sigma for sex
  
  real mu_bmi; // hyperprior mu for bmi
  real <lower=0> tau_bmi;//hyperprior tau for bmi
  real <lower=0> hyper_alpha_bmi;
  real theta_bmi; //hierarchial prior mu for bmi
  real <lower=0> sigma_bmi; //hierarchial prior sigma for bmi
  real <lower=0> prior_alpha_bmi;
  
  real mu_smoker; // hyperprior mu for smoker
  real <lower=0> tau_smoker;//hyperprior tau for smoker
  real theta_smoker; //hierarchial prior mu for smoker
  real <lower=0> sigma_smoker; //hierarchial prior sigma for smoker
  
  real mu_insurance; // hyperprior mu for insurance
  real <lower=0> tau_insurance;//hyperprior tau for insurance
  real theta_insurance; //hierarchial prior mu for insurance
  real <lower=0> sigma_insurance; //hierarchial prior sigma for insurance
}

//transformed parameters {
//  vector[N] mu = alpha + beta*age;
//}

model {
  //y ~ normal(mu, sigma);
  mu_age ~ normal(100 , 50);
  tau_age ~ cauchy(0, 40);
   
  mu_sex ~ normal(100 , 50);
  tau_sex ~ cauchy(0, 40);
   
  mu_bmi ~ skew_normal(50, 50, 0.5);
  tau_bmi ~ cauchy(0, 50);
  hyper_alpha_bmi ~ normal(0, 1);
   
  mu_smoker ~ normal(100 , 50);
  tau_smoker ~ cauchy(0, 40);
  
  mu_insurance ~ normal(100 , 50);
  tau_insurance ~ cauchy(0, 40);
  
  theta_age ~ normal (mu_age , tau_age);
  sigma_age ~ cauchy(0, 40);
  
  theta_sex ~ normal (mu_sex , tau_sex);
  sigma_sex ~ cauchy(0, 40);
  
  theta_bmi ~ skew_normal(mu_bmi , tau_bmi, hyper_alpha_bmi);
  sigma_bmi ~ cauchy(0, 50);
  prior_alpha_bmi ~ normal(0, 1);
  
  theta_smoker ~ normal (mu_smoker , tau_smoker);
  sigma_smoker ~ cauchy(0, 40);
  
  theta_insurance ~ normal (mu_insurance , tau_insurance);
  sigma_insurance ~ cauchy(0, 40);
  
  age ~ normal ( theta_age, sigma_age);
  sex ~ normal ( theta_sex, sigma_sex);
  bmi ~ skew_normal( theta_bmi, sigma_bmi, prior_alpha_bmi);
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
  bmi_pred = skew_normal_rng ( theta_bmi , sigma_bmi, prior_alpha_bmi);
  smoker_pred = normal_rng ( theta_smoker , sigma_smoker);
  insurance_pred = normal_rng ( theta_insurance , sigma_insurance);
}
