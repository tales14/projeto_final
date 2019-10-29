##### PROJETO FINAL - GRAFICOS CIENTIFICOS NO R
## TALES MARTINS - 

#### PACOTES UTITLIZADOS -----
library(tidyverse)

#### IMPORTANDO E LIMPANDO DADOS BRUTOS ----
data_mur <- read.csv("data/raw/murder_total.csv")
data_edu <- read.csv("data/raw/expenditure_per_student_secondary_percent_of_gdp_per_person.csv")

#### LIMPANDO DADOS ---
# TRANSFORMANDO PARA TIDY DATA
dat_mur <- data_mur %>% 
  pivot_longer(cols = -country, names_to = "year",
               values_to = "n")
dat_edu <- data_edu %>% 
  pivot_longer(cols = -country, names_to = "year",
               values_to = "n")

# CORRIGINDO O NOME DA VARIAVEL 'year'
dat_mur$year <-as.numeric(gsub(pattern = "X", replacement = "",
                               x = dat_mur$year))
dat_edu$year <-as.numeric(gsub(pattern = "X", replacement = "",
                               x = dat_edu$year))


  
  


