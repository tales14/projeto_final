##### PROJETO FINAL - GRAFICOS CIENTIFICOS NO R
## TALES MARTINS - 30/10/2019

## Relacao entre investivemnto em educacao primaria e indice de desen
## volvimento humando nos paises do mercosul

#### PACOTE UTITLIZADO -----
library(tidyverse)
library(inspectdf)

#### IMPORTANDO DADOS BRUTOS --------------------------------------
data_idh <- read.csv("data/raw/hdi_human_development_index.csv")
data_edu <- read.csv("data/raw/expenditure_per_student_primary_percent_of_gdp_per_person.csv")

#### 1. LIMPEZA INICIAL -------------------------------------------
# 1.1 TRANSFORMANDO PARA TIDY DATA --------------------------------
dat_idh <- data_idh %>% 
  pivot_longer(cols = -country, names_to = "year",
               values_to = "n")
dat_edu <- data_edu %>% 
  pivot_longer(cols = -country, names_to = "year",
               values_to = "n")

# 1.2 CORRIGINDO O NOME DA VARIAVEL 'year' ------------------------
dat_idh$year <-as.numeric(gsub(pattern = "X", replacement = "",
                               x = dat_idh$year))
dat_edu$year <-as.numeric(gsub(pattern = "X", replacement = "",
                               x = dat_edu$year))


# EDUCATION - basic checks ----------------------------------------
nrow(dat_edu)             # How many rows
str(dat_edu)              # Variables classes
attributes(dat_edu)       # Attributres
head(dat_edu)             # First rows
any(duplicated(dat_edu))  # There is any duplicated rows?
any(is.na(dat_edu))       # There are NAs in the data?

# IDH - basic checks ----------------------------------------------
nrow(dat_idh)             # How many rows
str(dat_idh)              # Variables classes
attributes(dat_idh)       # Attributres
head(dat_idh)             # First rows
any(duplicated(dat_idh))  # There is any duplicated rows?
any(is.na(dat_idh))       # There are NAs in the data?  
  

# CHECKING NAs ----------------------------------------------------
inspect_na(dat_edu) # Percentage of NA in each columns
inspect_na(dat_idh) # Percentage of NA in each columns

# Remove NAs
dat_edu <- na.omit(dat_edu)
dat_idh <- na.omit(dat_idh)

# CHECK NAs TO CONFIRM
inspect_na(dat_edu) # Percentage of NA in each columns
inspect_na(dat_idh) # Percentage of NA in each columns


## SELECIONANDO PAISES DO MERCOSUL --------------------------------
edu  <- filter(dat_edu, country %in% c("Brazil", "Argentina", "Uruguay",
                                     "Paraguay"))
               
idh  <- filter(dat_idh, country %in% c("Brazil", "Argentina", "Uruguay",
                                       "Paraguay"))


## CRIANDO UM UNICO BANCO DE DADOS PROCESSADOS --------------------
ms <- left_join(x = edu, y = idh, by = c("country","year"))
colnames(ms) <- c("country", "year", "edu", "idh")
ms <- na.omit(ms)

## SALVANDO BANCO DE DADOS PROCESSADO -----------------------------

write.csv(x = ms, file = "data/processed/dat_ms.csv", row.names = F)

######## FIM ---
