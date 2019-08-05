# gonna load some packages I frequently use
library(tidyverse)
library(magrittr)
# then let's load the foreach package
library(foreach)

# foreach is similar to a for loop, but not the same
# foreach is actually a function, so it returns the result of the "loop"
# that also means assigning values within foreach doesn't always quite work

?foreach

# let's start with an example and then dig into what's going on

foreach(i = 1:10) %do% {
  sqrt(i+j)
}

# notice that it's i = 1:10 not "i in 1:10" or "i %in% 1:10"
# what if we want to keep that vector of results instead of just printing it?

square_roots <- foreach(i = 1:10, .combine = append) %do% {
  sqrt(i+j)
}

# .combine tells the foreach how to combine the results it gets
# in this case I used append, which sticks everything in a vector
# .combine = c does the same thing but I think append is clearer

m <- matrix(rnorm(9), 3, 3)
column_means <- foreach(i=1:ncol(m), .combine=c) %do%
  mean(m[, i])

row_means <- foreach(i=1:nrow(m), .combine=c) %do%
  mean(m[i, ])
