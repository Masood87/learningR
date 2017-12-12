#### SAP analysis ####
library(haven)
sap <- read_stata("/Users/macbookair/Downloads/SAP 2017/data/TAF Merge W1-12 Client Version v3.dta")
sap$m6b[is.na(sap$m6b) & sap$m6a == 1] <- 1
sap$m6b[is.na(sap$m6b) & sap$m6a > 1] <- 2

# line graph for right direction
library(ggplot2)
library(dplyr)
sap %>% filter(!is.na(MergeWgt10)) %>% group_by(m8) %>% summarise(right = mean(x4_m == 101)*100) %>% 
  ggplot(aes(x = m8, y = right)) + geom_line()
sap %>% filter(!is.na(MergeWgt10)) %>% group_by(m4, m8) %>% summarise(right = mean(x4_m == 101)*100) %>%
  ggplot(aes(x = m8, y = right, color = as.factor(m4))) + geom_line()
sap %>% filter(!is.na(MergeWgt10), m4 == 4 | m4 == 8) %>% group_by(m7, m8) %>% summarise(right = mean(x4_m == 101)*100, m4 = mean(m4)) %>%
  ggplot(aes(m8, right, color = as.factor(m7))) + geom_line() + facet_wrap(~ m4)

# Weighted using survey package
library(survey)
library(data.table)
sap <- na.omit(sap$MergeWgt10)
sap <- sap[m8==2017]
sap.w <- svydesign(ids = ~1, data = sap, weights = sap$MergeWgt10)
colnames(sap)
table(sap$m8)

