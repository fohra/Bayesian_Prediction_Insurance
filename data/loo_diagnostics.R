loo_diagnostics <- function(model, parameter_name){
  pars = c(parameter_name)
  log_lik_1 <- extract_log_lik(model, parameter_name = pars, merge_chains = FALSE)
  r_eff_1 <- relative_eff(exp(log_lik_1), cores = 2)
  loo_1 <- loo(log_lik_1, r_eff = r_eff_1, cores = 2, save_psis = TRUE)
  print(loo_1)
}