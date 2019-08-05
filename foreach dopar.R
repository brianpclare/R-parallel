library(tidyverse)
library(magrittr)
library(foreach)

# the more powerful way to use foreach is instead of %do%, using %dopar%
# this will let you run your "loop" in parallel, doing multiple steps at once

# to do this, we'll need some more packages
library(parallel)
library(doSNOW)
# setup may be different for Macs

# for parallel computing, you need to define your machine as a cluster
# and specify the number of cores you'll use

num_cores <- parallel::detectCores()
# for my laptop this is 4, your mileage may vary
# the general recommendation is to leave one core free for your OS, so really
num_cores <- detectCores() - 1

cl <- snow::makeCluster(num_cores, type = "SOCK")
# you may get a pop-up asking if you want rstudio to have some access

# next, make clear this cluster is what's going to be used for %dopar%
registerDoSNOW(cl)

# now let's try a foreach
m <- matrix(rnorm(9), 3, 3)

foreach(i = 1:nrow(m), .combine=rbind) %dopar%{ 
  (m[i,] / mean(m[i,]))
  }
# if you see the result, that means your cluster exists and everything worked okay
# when you're done, you should close the cluster
stopCluster(cl)

# and that's the basic idea

# if you're doing something more complicated in the foreach, you may need .packages
# since each core of your machine will be running R independently, they need to know 
# if there are any packages required for your instructions
# the example above was only a base R operation