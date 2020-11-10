data {
  int<lower=0> N; // number of data points
  vector[N] age; 
  vector[N] sex;
  vector[N] bmi; //body mass index
  vector[N] smoker; // non-smoker 0, smoker 1
  vector[N] y; // insurance for person
  real xpred; //predict based on age
}

parameters {
  real alpha;
  real beta;
  real<lower=0> sigma;
}

transformed parameters {
  vector[N] mu = alpha + beta*age;
}

model {
  y ~ normal(mu, sigma);
}

generated quantities {
  real ypred = normal_rng(alpha + beta*xpred, sigma);
}
