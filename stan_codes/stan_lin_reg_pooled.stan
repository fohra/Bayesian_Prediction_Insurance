data {
  int<lower=0> N; // number of data points
  vector[N] age; 
  vector[N] children;
  vector[N] bmi; //body mass index
  vector[N] smoker; // non-smoker 0, smoker 1
  vector[N] y; // insurance for person
  real pred_age; //predict based on age
  real pred_bmi;
  real pred_smoker;
  real pred_children;
}

parameters {
  real<lower=0>alpha;
  real beta_age;
  real beta_bmi;
  real beta_smoker;
  real beta_children;
  real<lower=0> sigma;
}

transformed parameters {
  vector[N] mu = alpha + beta_age*age + beta_bmi*bmi + beta_smoker*smoker + beta_children*children;
}

model {
  beta_age ~ normal(100,1000);
  beta_children ~ normal(100,1000);
  beta_bmi ~ normal(100,1000);
  beta_smoker ~ normal(100,1000);
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