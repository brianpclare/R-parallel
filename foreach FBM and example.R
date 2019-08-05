library(tidyverse)
library(magrittr)
library(foreach)
library(parallel)
library(doSNOW)

# in this script, we'll show a more realistic example of foreach usage
# including using bigstatsr FBM type to save results from a foreach loop

library(bigstatsr)
