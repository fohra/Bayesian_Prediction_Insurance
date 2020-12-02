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
}

transformed parameters {
  vector[N] mu = alpha + beta_age*age + beta_bmi*bmi + beta_smoker*smoker;
}

model {
  beta_age ~ normal(0,100);
  beta_bmi ~ normal(0,100);
  beta_smoker ~ normal(0,1000);
  y ~ normal(mu, sigma);
}

generated quantities {
  vector[N] log_lik_y;
  real ypred = normal_rng(alpha + beta_age*pred_age + beta_bmi*pred_bmi + beta_smoker*pred_smoker, sigma);
  int i=1;
  for(n in 1:N){
        log_lik_y[i] = normal_lpdf(y[n] | mu, sigma);
        i=i+1;
  }
}
