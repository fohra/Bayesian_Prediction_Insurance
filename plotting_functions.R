# Histogram with density plot
plot_hist_with_dnm <- function(draw){
  p <- ggplot(as.data.frame(draw),aes(x=draw)) + 
    geom_histogram(aes(y=..density..), colour="black", fill="white",binwidth=35)+
    geom_density(alpha=.2, fill="#E69F00")
  p <- p+ geom_vline(aes(xintercept=mean(draw)),
                     color="blue", linetype="dashed", size=1)
  return (p)
}

plot_5 <- function(draws){
  mu <- gather(as.data.frame(draws$mu), cols, value) 
  p1 <- plot_hist_with_dnm(draws$alpha) + ggtitle("alpha")
  p2 <- plot_hist_with_dnm(draws$beta_age) + ggtitle("beta_age")
  
  p3 <- plot_hist_with_dnm(draws$beta_sex) + ggtitle("beta_sex")
  p4 <- plot_hist_with_dnm(draws$beta_bmi) + ggtitle("beta_bmi")
  
  p5 <- plot_hist_with_dnm(draws$beta_smoker) + ggtitle("beta_smoker")
  p6 <- plot_hist_with_dnm(draws$children) + ggtitle("children")
  
  p7 <- plot_hist_with_dnm(mu$value) + ggtitle("mu")
  p8 <- plot_hist_with_dnm(draws$ypred) + ggtitle("ypred")
  
  
  
  grid.arrange(
    p1,p2,p3,p4,p5,p6,p7,p8,
    widths = c(1, 1),
    layout_matrix = rbind(c(1, 2),
                          c(3, 4),
                          c(5,6),
                          c(7,7),
                          c(8,8))
  )
}

plot_4_no_sex <- function(draws){
  mu <- gather(as.data.frame(draws$mu), cols, value) 
  p1 <- plot_hist_with_dnm(draws$alpha) + ggtitle("alpha")
  p2 <- plot_hist_with_dnm(draws$beta_age) + ggtitle("beta_age")

  p4 <- plot_hist_with_dnm(draws$beta_bmi) + ggtitle("beta_bmi")
  
  p5 <- plot_hist_with_dnm(draws$beta_smoker) + ggtitle("beta_smoker")
  p6 <- plot_hist_with_dnm(draws$children) + ggtitle("children")
  
  p7 <- plot_hist_with_dnm(mu$value) + ggtitle("mu")
  p8 <- plot_hist_with_dnm(draws$ypred) + ggtitle("ypred")
  
  
  
  grid.arrange(
    #grobs = c(p1,p2,p4,p5,p6,p7,p8),
    p1,p2,p4,p5,p6,p7,p8,
    widths = c(1, 1),
    layout_matrix = rbind(c(1, 2),
                          c(NA,3),
                          c(4,5),
                          c(6,6),
                          c(7,7))
  )
}

plot_4_no_children <- function(draws){
  mu <- gather(as.data.frame(draws$mu), cols, value) 
  p1 <- plot_hist_with_dnm(draws$alpha) + ggtitle("alpha")
  p2 <- plot_hist_with_dnm(draws$beta_age) + ggtitle("beta_age")
  p3 <- plot_hist_with_dnm(draws$beta_sex) + ggtitle("beta_sex")
  
  
  p4 <- plot_hist_with_dnm(draws$beta_bmi) + ggtitle("beta_bmi")
  
  p5 <- plot_hist_with_dnm(draws$beta_smoker) + ggtitle("beta_smoker")

  p7 <- plot_hist_with_dnm(mu$value) + ggtitle("mu")
  p8 <- plot_hist_with_dnm(draws$ypred) + ggtitle("ypred")
  
  
  
  grid.arrange(
    p1,p2,p3,p4,p5,p7,p8,
    widths = c(1, 1),
    layout_matrix = rbind(c(1, 2),
                          c(3,4),
                          c(5,NA),
                          c(6,6),
                          c(7,7))
  )
}

plot_3 <- function(draws){
  mu <- gather(as.data.frame(draws$mu), cols, value) 
  p1 <- plot_hist_with_dnm(draws$alpha) + ggtitle("alpha")
  p2 <- plot_hist_with_dnm(draws$beta_age) + ggtitle("beta_age")
  
  p4 <- plot_hist_with_dnm(draws$beta_bmi) + ggtitle("beta_bmi")
  
  p5 <- plot_hist_with_dnm(draws$beta_smoker) + ggtitle("beta_smoker")
  
  p7 <- plot_hist_with_dnm(mu$value) + ggtitle("mu")
  p8 <- plot_hist_with_dnm(draws$ypred) + ggtitle("ypred")
  
  
  
  grid.arrange(
    p1,p2,p4,p5,p7,p8,
    widths = c(1, 1),
    layout_matrix = rbind(c(1, 2),
                          c(3,4),
                          c(5,NA),
                          c(6,6),
                          c(7,7))
  )
}

