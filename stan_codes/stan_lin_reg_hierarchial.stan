data {
  int<lower=0> N; // number of data points
  vector[N] age; 
  //vector[N] sex; 
  //vector[N] region; 
  vector[N] children; 
  vector[N] bmi; //body mass index
  vector[N] smoker; // non-smoker 0, smoker 1
  vector[N] y; // insurance for person
  real pred_age; //predict based on age
  real pred_bmi;
  real pred_smoker;
  //real pred_sex;
  //real pred_region;
  real pred_children;
}

parameters {
  real <lower=0> alpha;
  real beta_age;
  real beta_bmi;
  real beta_smoker;
  //real beta_region;
  real beta_children;
  //real beta_sex;
  real <lower=0> sigma;
  
  real <lower=0>mu_age; // hyperprior mu for age
  real <lower=0>tau_age;//hyperprior tau for age
  
  //real <lower=0>mu_sex; // hyperprior mu for age
  //real <lower=0>tau_sex;//hyperprior tau for age
  
  real <lower=0>mu_bmi; // hyperprior mu for bmi
  real <lower=0>tau_bmi;//hyperprior tau for bm
  
  //real <lower=0>mu_region; // hyperprior mu for bmi
  //real <lower=0>tau_region;//hyperprior tau for bm
  
  real <lower=0>mu_children; // hyperprior mu for bmi
  real <lower=0>tau_children;//hyperprior tau for bm
  
  real <lower=0>mu_smoker; // hyperprior mu for smoker
  real <lower=0>tau_smoker;//hyperprior tau for smoker
 
}

transformed parameters {
  
  vector[N] mu = alpha + beta_age*age + beta_bmi*bmi+beta_children*children + beta_smoker*smoker;
}

model {
   mu_age ~ normal(100 , 1000);
   tau_age ~ normal(1000,100);
   
   //mu_sex ~ normal(100 , 1000);
   //tau_sex ~ normal(1000,100);
   
   mu_bmi ~ normal(100, 1000);
   tau_bmi ~ normal(1000, 100);
   
   mu_smoker ~ normal(1000 , 1000);
   tau_smoker ~ normal(1000, 1000);
   
   //mu_region ~ normal(100, 1000);
   //tau_region ~ normal(1000, 100);
   
   mu_children ~ normal(100 , 1000);
   tau_children ~ normal(1000, 100);

   beta_age ~ normal ( mu_age, tau_age);
   beta_bmi ~ normal( mu_bmi, tau_bmi);
   //beta_sex ~ normal( mu_sex, tau_sex);
   beta_smoker ~ normal ( mu_smoker, tau_smoker);
   //beta_region ~ normal ( mu_region, tau_region);
   beta_children ~ normal ( mu_children, tau_children);
   alpha ~ normal(1000,100);
   sigma ~ normal(1000,1000);
   
   y ~ normal(mu, sigma);
}

generated quantities {
  vector[N] log_lik_y;
  int i;
  int K;
  
  real ypred = fabs(normal_rng(alpha + beta_age*pred_age + beta_bmi*pred_bmi +beta_children*pred_children + beta_smoker*pred_smoker, sigma));
  i=1;
  for(n in 1:N){
        log_lik_y[i] = normal_lpdf(y[n] | alpha + beta_age*pred_age + beta_bmi*pred_bmi + beta_children*pred_children + beta_smoker*pred_smoker, sigma);
        i=i+1;
  }
}