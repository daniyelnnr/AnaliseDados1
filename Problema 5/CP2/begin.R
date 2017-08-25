library(GGally)
library(pscl)
library(broom)
library(tidyverse)
library(modelr) # devtools::install_github("hadley/modelr")

speed2 <- read_csv("https://raw.githubusercontent.com/nazareno/ciencia-de-dados-1/master/5-regressao/speed-dating/speed-dating2.csv") %>% na.omit()

speed2 <- speed2 %>%
  mutate(dec = ifelse(dec == "yes", 1, 0))

data <- speed2 %>%
  select(dec, attr, race)

m <- glm(dec ~ race, 
         data = speed2,
         family = "binomial")
tidy(m,conf.int = TRUE)

ggpairs(data)
