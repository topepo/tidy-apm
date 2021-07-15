library(tidymodels)

data(grants)

grants_split <- validation_split(grants_other, prop = length(grants_2008)/nrow(grants_other))
grants_split$splits[[1]]$in_id <- grants_2008
grants_split$splits[[1]]$out_id <- seq_len(nrow(grants_other))[-grants_2008]

save(grants_split, file = "RData/grants_split.RData", version = 2)