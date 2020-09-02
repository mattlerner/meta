data {
 int < lower = 1 > N; // Number of studies
 vector[N] rate; // rate
 vector[N] error; // standard errors
 vector[N] sample; // sample size
}

parameters { 
  real normal_mu;
  real theta[N];
  real<lower=0> tau;
  real alpha;
  real beta;
}


model {
  rate ~ beta(alpha, beta);
  rate ~ normal(theta, error);
  theta ~ normal(normal_mu, tau);
  normal_mu ~ normal(0, 10);
  tau ~ cauchy(0, 5);
}