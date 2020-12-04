# Histogram with density plot
plot_hist_with_dnm <- function(draw){
  p <- ggplot(as.data.frame(draw),aes(x=draw)) + 
    geom_histogram(aes(y=..density..), colour="black", fill="white",binwidth=35)+
    geom_density(alpha=.2, fill="#E69F00")
  p <- p+ geom_vline(aes(xintercept=mean(draw)),
                     color="blue", linetype="dashed", size=1)
  return (p)
}

