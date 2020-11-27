data {
  int<lower=0> N; // number of data points
  vector[N] age; 
  vector[N] sex;
  vector[N] bmi; //body mass index
  vector[N] smoker; // non-smoker 0, smoker 1
  vector[N] y; // insurance for person
  real pred_age; //predict based on age
  real pred_sex;
  real pred_bmi;
  real pred_smoker;
}

parameters {
  real alpha;
  real beta_age;
  real beta_sex;
  real beta_bmi;
  real beta_smoker;
  real<lower=0> sigma;
  
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
}

transformed parameters {
  
  vector[N] mu = alpha + beta_age*age + beta_sex*sex + beta_bmi*bmi + beta_smoker*smoker;
}

model {
   mu_age ~ normal(0 , 50);
   tau_age ~ normal(0, 40);

   mu_sex ~ normal(0 , 50);
   tau_sex ~ normal(0, 40);
   
   mu_bmi ~ normal(0, 50);
   tau_bmi ~ skew_normal(0, 40, 0);
   prior_alpha_bmi ~ normal(0, 1);
   
   mu_smoker ~ normal(0 , 50);
   tau_smoker ~ normal(0, 40);
   
   beta_age ~ normal ( mu_age, tau_age);
   beta_sex ~ normal ( mu_sex, tau_sex);
   beta_bmi ~ skew_normal( mu_bmi, tau_bmi, prior_alpha_bmi);
   beta_smoker ~ normal ( mu_smoker, tau_smoker);
   
   alpha ~ normal(0,1);
   sigma ~ normal(0,9);
   
   y ~ normal(mu, sigma);
}

generated quantities {
  vector[N] log_lik_y;
  int i;
  int K;
  
  real ypred = normal_rng(alpha + beta_age*pred_age + beta_sex*pred_sex + beta_bmi*pred_bmi + beta_smoker*pred_smoker, sigma);
  i=1;
  K=100;
  for(n in 1:N){
        log_lik_y[i] = normal_lpdf(y[n] | alpha + beta_age*pred_age + beta_sex*pred_sex + beta_bmi*pred_bmi + beta_smoker*pred_smoker, sigma);
        i=i+1;
  }
}
