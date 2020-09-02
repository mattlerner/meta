data {
 int < lower = 1 > N; // Number of studies
 vector[N] rate; // rate
 vector[N] error; // standard errors
 vector[N] sample; // sample size
}

transformed data {
	real successes[N];
	real failures[N];

	for (n in 1:N)
	  successes[n] = round(rate[n] * sample[n]);

	for (n in 1:N)
	  failures[n] = sample[n] - successes[n];
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