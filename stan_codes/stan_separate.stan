data {
  int<lower=0> N; // number of data points
  vector[N] age; // age of person
  vector[N] sex; // female 0, male 1
  vector[N] bmi; //body mass index
  vector[N] smoker; // non-smoker 0, smoker 1
  vector[N] insurance; // insurance for person
  
  
}

parameters {
  
  vector[N] mu_age; // hyperprior mu for age
  vector[N] tau_age;//hyperprior tau for age
  vector[N] theta_age; //hierarchial prior mu for age
  vector[N] sigma_age ; //hierarchial prior sigma for age
  
  vector[N] mu_sex; // hyperprior mu for sex
  vector[N] tau_sex;//hyperprior tau for sex
  vector[N] theta_sex; //hierarchial prior mu for sex
  vector[N] sigma_sex ; //hierarchial prior sigma for sex
  
  vector[N] mu_bmi; // hyperprior mu for bmi
  vector[N] tau_bmi;//hyperprior tau for bmi
  vector[N] hyper_alpha_bmi;
  vector[N] theta_bmi; //hierarchial prior mu for bmi
  vector[N] sigma_bmi; //hierarchial prior sigma for bmi
  vector[N] prior_alpha_bmi;
  
  vector[N] mu_smoker; // hyperprior mu for smoker
  vector[N] tau_smoker;//hyperprior tau for smoker
  vector[N] theta_smoker; //hierarchial prior mu for smoker
  vector[N] sigma_smoker; //hierarchial prior sigma for smoker
  
  vector[N] mu_insurance; // hyperprior mu for insurance
  vector[N] tau_insurance;//hyperprior tau for insurance
  vector[N] theta_insurance; //hierarchial prior mu for insurance
  vector[N] sigma_insurance; //hierarchial prior sigma for insurance
  vector[N] hyper_alpha_insurance;
  vector[N] prior_alpha_insurance;
  
}


model {
  for (n in 1:N){
    mu_age[n] ~ normal(100 , 50);
    tau_age[n] ~ cauchy(0, 40);
    }

  for (n in 1:N){
    mu_sex[n] ~ normal(100 , 50);
    tau_sex[n] ~ cauchy(0, 40);
    }

  for (n in 1:N){
    mu_bmi[n] ~ skew_normal(50, 50, 0.5);
    tau_bmi[n] ~ cauchy(0, 50);
    hyper_alpha_bmi[n] ~ normal(0, 1);
    }

  for (n in 1:N){
    mu_smoker[n] ~ normal(100 , 50);
    tau_smoker[n] ~ cauchy(0, 40);
    }
  
  for (n in 1:N){
    mu_insurance[n] ~ skew_normal(0, 100, 1);
    tau_insurance[n] ~ cauchy(0, 100);
    hyper_alpha_insurance[n] ~ normal(0, 1);
    }
  
  for (n in 1:N){
    theta_age[n] ~ normal (mu_age[n] , tau_age[n]);
    sigma_age[n] ~ cauchy(0, 40);
    }
  for (n in 1:N){
    theta_sex[n] ~ normal (mu_sex[n] , tau_sex[n]);
    sigma_sex[n] ~ cauchy(0, 40);
    }
  for (n in 1:N){
    theta_bmi[n] ~ skew_normal(mu_bmi[n] , tau_bmi[n], hyper_alpha_bmi[n]);
    sigma_bmi[n] ~ cauchy(0, 50);
    prior_alpha_bmi[n] ~ normal(0, 1);
    }
  for (n in 1:N){
    theta_smoker[n] ~ normal (mu_smoker[n] , tau_smoker[n]);
    sigma_smoker[n] ~ cauchy(0, 40);
    }
  for (n in 1:N){
    theta_insurance[n] ~ skew_normal(mu_insurance[n] , tau_insurance[n], hyper_alpha_insurance[n]);
    sigma_insurance[n] ~ cauchy(0, 1000);
    prior_alpha_insurance[n]  ~ normal(0, 1);
  }
  for (n in 1:N){
    age[n] ~ normal ( theta_age[n], sigma_age[n]);
    sex[n] ~ normal ( theta_sex[n], sigma_sex[n]);
    bmi[n] ~ skew_normal( theta_bmi[n], sigma_bmi[n], prior_alpha_bmi[n]);
    smoker[n] ~ normal ( theta_smoker[n], sigma_smoker[n]);
    insurance[n] ~ skew_normal ( theta_insurance[n], sigma_insurance[n], prior_alpha_insurance[n]);
  }
  

  
}

generated quantities {
  vector[N] age_pred;
  vector[N] sex_pred;
  vector[N] bmi_pred;
  vector[N] smoker_pred;
  vector[N] insurance_pred;
  
  vector[N] log_lik_age;
  vector[N] log_lik_sex;
  vector[N] log_lik_bmi;
  vector[N] log_lik_smoker;
  vector[N] log_lik_insurance;
  
  int i;
  int K;
  
  for (n in 1:N){
    age_pred[n] = normal_rng ( theta_age[n] , sigma_age[n]);
    sex_pred[n] = normal_rng ( theta_sex[n] , sigma_sex[n]);
    bmi_pred[n] = skew_normal_rng ( theta_bmi[n] , sigma_bmi[n], prior_alpha_bmi[n]);
    smoker_pred[n] = normal_rng ( theta_smoker[n] , sigma_smoker[n]);
    insurance_pred[n] = fabs(skew_normal_rng ( theta_insurance[n] , sigma_insurance[n], prior_alpha_insurance[n]));
  }
  
  
  i=1;
  K=100;
  for(n in 1:N){
        log_lik_age[i] = normal_lpdf(age[n] | theta_age[n], sigma_age[n]);
        i=i+1;
  }
  i=1;
  for(n in 1:N){
        log_lik_sex[i] = normal_lpdf(sex[n] | theta_sex[n], sigma_sex[n]);
        i=i+1;
  }
  i=1;
  for(n in 1:N){
        log_lik_bmi[i] = skew_normal_lpdf(bmi[n] | theta_bmi[n], sigma_bmi[n], prior_alpha_bmi[n]);
        i=i+1;
  }
  i=1;
  for(n in 1:N){
        log_lik_smoker[i] = normal_lpdf(smoker[n] | theta_smoker[n], sigma_smoker[n]);
        i=i+1;
  }
  i=1;
  for(n in 1:N){
        log_lik_insurance[i] = skew_normal_lpdf(insurance[n] | theta_insurance[n], sigma_insurance[n], prior_alpha_insurance[n]);
        i=i+1;
  }
   
  
}

