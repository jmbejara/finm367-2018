# In R, there are many libraries. Sometimes, the same tasks can be done with many different
# libraries and functions. Some of these libraries are newer than others and do things in a
# way that is considered preferrable to the old way of doing things.
# There is a set of libraries called "the tidyverse" (https://www.tidyverse.org/) 
# that is a collection of
# newer libraries that are very popular right now. I highly recommend using them.
# They provide a modern, unified approach to doing data science in R.
#
# loading the tidyverse as a package is a convenience function that
# loads all of the "core tidyverse packages" at once.
library(tidyverse)
# readxl is needed for loading data from excel files
library(readxl)

# sometimes the read_xlsx function can infer the proper data types on its own.
# It needs a little help here, though.
col_types = c('date', rep('numeric', 12))
df_whole = read_xlsx('data/assetclass_data_monthly.xlsx', sheet='data', col_types = col_types)

# select out the date column
dates = df_whole %>% select('Dates')
# create a table of only the numeric columns (for convenience)
df = df_whole %>% select(-one_of('Dates'))

# use the question mark before a function to bring up the help documentation
?colMeans

# Here I'm using the pipe notation provided by the tidyverse
df %>% colMeans(na.rm = TRUE)
# This is equivalent to the following (the pipe merely inserts the previous result
# into the first argument of the following function)
colMeans(df, na.rm = TRUE)

# To compute the variance-covariance matrix, you have a few options. If you use the default
# option, you'll have a lot of NAs in the result.
df %>% cov

# You can compute the covariance pairwise and drop the NAs in between each pair:
df %>% cov(use='pairwise.complete.obs')

# Or, you can drop the observations needed to get a fully balanced panel
df %>% cov(use='complete.obs')

# This is equivalent to the following:
df %>% drop_na %>% cov
