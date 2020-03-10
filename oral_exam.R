library(tidyverse)
oral = read.csv("oral.csv")

set.seed(5)

oral %>%
  group_by(group) %>%
  filter(row_number() == sample(1:n(), size =1))
