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
  real beta_bmi;
  real beta_smoker;
  real<lower=0> sigma;
  
  real mu_age; // hyperprior mu for age
  real <lower=0> tau_age;//hyperprior tau for age
  
  real mu_bmi; // hyperprior mu for bmi
  real <lower=0> tau_bmi;//hyperprior tau for bmi
  
  real mu_smoker; // hyperprior mu for smoker
  real <lower=0> tau_smoker;//hyperprior tau for smoker
}

transformed parameters {
  
  vector[N] mu = alpha + beta_age*age + beta_bmi*bmi + beta_smoker*smoker;
}

model {
   mu_age ~ normal(100 , 20);
   tau_age ~ normal(0, 50);
   
   mu_bmi ~ normal(50, 10);
   tau_bmi ~ normal(0, 10);
   
   mu_smoker ~ normal(5000 , 500);
   tau_smoker ~ normal(0, 400);

   beta_age ~ normal ( mu_age, tau_age);
   beta_bmi ~ normal( mu_bmi, tau_bmi);
   beta_smoker ~ normal ( mu_smoker, tau_smoker);
   
   alpha ~ normal(0,1000);
   sigma ~ normal(0,1000);
   
   y ~ normal(mu, sigma);
}

generated quantities {
  vector[N] log_lik_y;
  int i;
  int K;
  
  real ypred = normal_rng(alpha + beta_age*pred_age + beta_bmi*pred_bmi + beta_smoker*pred_smoker, sigma);
  i=1;
  K=100;
  for(n in 1:N){
        log_lik_y[i] = normal_lpdf(y[n] | alpha + beta_age*pred_age + beta_bmi*pred_bmi + beta_smoker*pred_smoker, sigma);
        i=i+1;
  }
}
