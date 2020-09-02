library(rstan)

setwd("/users/matt/desktop/stan")

rates.raw <- c(13,64,19,10,12,2,47,0)
rates <- rates.raw / 100
samples <- c(16,22,17,17,69,38,1500,27)
errors <- sqrt((rates*(1 - rates))/samples) # standard error of the proportion
errors[errors == 0] = 2/(samples[errors == 0] + 4) # modified wald method for proportion confidence interval

stan_data <- list(rate=rates,error=errors,sample=samples,N=length(rates))

meta <- "meta.stan"
fit <- stan(file = meta, data = stan_data, control=list(adapt_delta=0.95), warmup = 500, iter = 4000, chains = 4)#, cores = 2, thin = 1)
posterior <- extract(fit)
plot(density(posterior$mu))
quantile(posterior$normal_mu, c(0.05,0.95))