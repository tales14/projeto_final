#### REALIZANDO AS ANALISES EXPLORATORIOS
## TALES MARTINS - 30/10/2019

## PACOTES
library(tidyverse)

## IMPORTANDO DO BANCO DE DADOS LIMPO PARA O MERCOSUL-----------------
ms <- read.csv(file = "data/processed/dat_ms.csv")

# 1. ANALISES EXPLORATORIAS-----

## 1.1 DISTRIBUICAO DA AMOSTRAGEM POR PAISES
dis <- 
  ggplot(ms, aes(x = country, fill  = country)) +
  geom_bar() +
  theme_bw(base_size = 20) +
  labs(x = "Country", y = "N") +
  scale_y_continuous(limits = c(0, 18), breaks = seq(0,18,2))

#### 1.2 GRAFICOS EXPLORATORIOS DO INVESTIMENTO EM EDUCACAO --------
edu <- 
  ggplot(ms, aes(x = year, y = edu, color = country)) +
  geom_point(size = 2) +
  geom_line(lwd = 1) +
  scale_x_continuous(limits = c(min(ms$year), max(ms$year)),
                     breaks = seq(1900,2020,2)) +
  labs(x = "Ano", y = "Investimento em ensino primário por estudante") +
  theme_bw(base_size = 20)

#### 1.3 GRAFICOS EXPLORATORIOS DO IDH ---------
idh <- 
  ggplot(ms, aes(x = year, y = idh, color = country)) +
  geom_point(size = 2) +
  geom_line(size = 1) +
  scale_x_continuous(limits = c(min(ms$year), max(ms$year)),
                     breaks = seq(1900,2020,2)) +
  labs(x = "Ano", y = "Indice de desenvolvimento humano (IDH)") +
  theme_bw(base_size = 20)


## 2. SALVANDO OS GRAFICOS EXPLORATORIOS SUPLEMENTARES ----------
ggsave(plot = dis, filename = "outputs/supp//01_Exp_DIS.png",
       width = 12, height = 8)
ggsave(plot = idh, filename = "outputs/supp//02_Exp_IDH.png",
      width = 12, height = 8)
ggsave(plot = edu, filename = "outputs/supp//03_Exp_EDU.png",
       width = 12, height = 8)

### FIM --- 
