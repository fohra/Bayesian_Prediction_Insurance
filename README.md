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

## Linear regression

We decided to start with a simple linear regression model. The model predicts insurance costs given persons age, sex, bmi and smoking status. We use these variables to fit a linear model and use it as a mean for a normal distribution. The normal distribution is used to fit to the insurance data. The model uses uniform priors for all the parameters. 

![alt text](https://github.com/fohra/Bayesian_Prediction_Insurance/blob/main/pictures/equation_lin_reg.PNG?raw=true)

We plotted histograms of the alphas and betas and predicted insurance costs for 25-year old male, whose bmi is 20 and who smokes. 

![alt text](https://github.com/fohra/Bayesian_Prediction_Insurance/blob/main/pictures/hist_for_lin_reg_uni1.png?raw=true)

Using uniform priors the posteriors of age, bmi and smoking status seem to fitted as a distribution with positive values. This means that when each of these increase so does the insurance costs. Smoking seems to have the highest affect on insurance costs. Sex on the other hand doesn't seem to be that clear. The mean of the posterior distribution is negative, but there is considerable amount of probability mass on the positive side. 

![alt text](https://github.com/fohra/Bayesian_Prediction_Insurance/blob/main/pictures/hist_for_lin_reg_uni2.png?raw=true)

Here we can see the posterior means of insurance costs for all the persons and the predictive posterior mean for the predicted person. From the left picture we can see that, the costs have two clusters. We have already seen from that the smokers tend to have considerably higher costs and the model seem to separate these two. The predicted posterior costs have a mean that lands on the lower end of the smoking peak. This might be due to the fact that the person is young and has a low bmi. 
