## sampling and surveys

# Sampling:
# - simple random sampling
# - stratified sampling: 1) divide into homogeneous groups (strata) 2) random sample within each strata
# - cluster sampling: 1) divide into clusters 2) random select few clusters 3) random select all obs in selected clusters
# - multistage sampling: 1) divide into clusters 2) random select few clusters 3) random select few obs in selected clusters


library(dplyr)

#simple randome sample
set.seed(100)
sample_n(data, size = 100) #randomly selects 100 obs
sample_frac(data, size = .1) #randomly selects 10% of obs
#sample.int(data, )

#stratified sample
count(group_by(data, var)) #library(dplyr)
data %>% group_by(var) %>% count()
set.seed(100)
sample_n(group_by(data, var), size = 5) #randomly select 5 obs for each category of var



# reshuffling and sampling
n <- nrow(data)
shuffled <- data[sample(n),]
sample50 <- data[sample(n*0.5),]


