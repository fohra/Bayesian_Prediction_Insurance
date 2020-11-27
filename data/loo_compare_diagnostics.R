loo_compare_diagnostics <- function(model1, model2, parameter_name1, parameter_name2){
  pars1 = c(parameter_name1)
  log_lik_1 <- extract_log_lik(model1, parameter_name = pars1, merge_chains = FALSE)
  r_eff_1 <- relative_eff(exp(log_lik_1), cores = 2)
  loo_1 <- loo(log_lik_1, r_eff = r_eff_1, cores = 2, save_psis = TRUE)
  print(loo_1)
  
  pars2 = c(parameter_name2)
  log_lik_2 <- extract_log_lik(model2, parameter_name = pars2, merge_chains = FALSE)
  r_eff_2 <- relative_eff(exp(log_lik_2), cores = 2)
  loo_2 <- loo(log_lik_2, r_eff = r_eff_2, cores = 2, save_psis = TRUE)
  print(loo_2)
  
  comp <- loo_compare(loo_1, loo_2)
  print(comp)
}