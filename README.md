# Bayesian_Prediction_Insurance

### Original Data
* **age**: int
* **sex**: factor female/male
* children: int
* **bmi**: num(float?)
* **smoker**: factor
* region: factor
* **charges**: num(float?)

![alt text](https://github.com/fohra/Bayesian_Prediction_Insurance/blob/main/pictures/pairs%20plots.png?raw=true)

**Pair plots for variables that are to be used**

![alt text](https://github.com/fohra/Bayesian_Prediction_Insurance/blob/main/pictures/variables_plotted_for_sex.png?raw=true)

**Histograms for both female and male**

![alt text](https://github.com/fohra/Bayesian_Prediction_Insurance/blob/main/pictures/variables_plotted_for_smoking.png?raw=true)

**Histograms for both non-smokers and smokers**

### Preprocessing

* Drops children and region variables
* Changes sex and smoker from factor to numerical

### Test run for linear stan model using uniform priors and age as a covariate

![alt text](https://github.com/fohra/Bayesian_Prediction_Insurance/blob/main/pictures/Histograms_for_test_stan_run.png?raw=true)

**Histograms of posteriors for intercept(alpha), slope(beta), means(mu) and prediction for a 25 year old person**

Note that the predictions for a 25 year old person cannot be negative. Need to be changed.
