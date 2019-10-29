#### REALIZANDO AS ANALISES EXPLORATORIOS

## PACOTES
library(tidyverse)

## IMPORTANDO DO BANCO DE DADOS LIMPO ------------------------------
dat <- read.csv(file = "data/processed/dat.csv")

## ANALISES EXPLORATORIAS-------------------------------------

# selecionando paises do Mercosul
ms <- filter(dat, country %in% c("Brazil", "Argentina", "Uruguay", "Paraguay"))

ggplot(ms, aes(x = idh, fill = country)) +
  geom_histogram(bins = 15, alpha = 0.7) +
  facet_grid(~country)+
  scale_x_continuous(limits = c(0.5,1), breaks = seq(0,1,0.1)) +
  theme_bw()
  
ggplot(ms, aes(x = edu, fill = country)) +
  geom_histogram(bins = 15, alpha = 0.7) +
  facet_grid(~country) +
  theme_bw()

ggplot(ms, aes(x = edu, y = idh, color = country)) +
  geom_point() +
  facet_grid(~country) +
  theme_bw()

## selecionando so o brasil
br <- filter(dat, country %in% "Brazil")

#### GRAFICOS EXPLORATORIOS DO INVESTIMENTO EM EDUCACAO

edu<- 
  ggplot(br, aes(x = year, y = edu)) +
  geom_point() +
  geom_line() +
  scale_x_continuous(limits = c(min(br$year), max(br$year)),
                     breaks = seq(1900,2020,1)) +
  scale_y_continuous(limits = c(9,21), breaks = seq(9,21,2)) +
  labs(x = "Ano", y = "Investimento em ensino primário por estudante") +
  theme_bw(base_size = 20)

edu_1<- 
  ggplot(br, aes(x = year, y = edu)) +
  geom_point() +
  geom_line() +
  scale_x_continuous(limits = c(min(br$year), max(br$year)),
                     breaks = seq(1900,2020,1)) +
  scale_y_continuous(limits = c(9,21), breaks = seq(9,21,2)) +
  geom_hline(yintercept = 19.6, slope = 0, lty = 6, color = "blue") +
  geom_hline(yintercept = min(br$edu), slope = 0, lty = 6, color = "red") +
  labs(x = "Ano", y = "Investimento em ensino primário por estudante") +
  theme_bw(base_size = 20)

#### GRAFICOS EXPLORATORIOS DO IDH ---------

idh <- 
  ggplot(br, aes(x = year, y = idh)) +
  geom_point(size = 2) +
  geom_line(size = 1) +
  scale_x_continuous(limits = c(min(br$year), max(br$year)),
                     breaks = seq(1900,2020,1)) +
  scale_y_continuous(limits = c(0.6, 0.8), breaks = seq(0.6,0.8,0.05)) +
  labs(x = "Ano", y = "Indice de desenvolvimento humano (IDH)") +
  theme_bw(base_size = 20)

idh_1 <- 
  ggplot(br, aes(x = year, y = idh)) +
  geom_point(size = 2) +
  geom_line(size = 1) +
  scale_x_continuous(limits = c(min(br$year), max(br$year)),
                     breaks = seq(1900,2020,1)) +
  geom_hline(yintercept = max(br$idh), slope = 0, lty = 2, color = "blue") +
  geom_hline(yintercept = min(br$idh), slope = 0, lty = 2, color = "red") +
  scale_y_continuous(limits = c(0.6, 0.8), breaks = seq(0.6,0.8,0.05)) +
  labs(x = "Ano", y = "Indice de desenvolvimento humano (IDH)") +
  theme_bw(base_size = 20)

## SALVANDO OS GRAFICOS EXPLORATORIOS ----------
ggsave(plot = idh, filename = "outputs/supp//01_Exp_IDH_BR.png",
      width = 12, height = 8)
ggsave(plot = idh_1, filename = "outputs/supp//02_Exp_IDH_BR.png",
       width = 12, height = 8)
ggsave(plot = edu, filename = "outputs/supp//03_Exp_EDU_BR.png",
       width = 12, height = 8)
ggsave(plot = edu_1, filename = "outputs/supp//04_Exp_EDU_BR.png",
       width = 12, height = 8)

