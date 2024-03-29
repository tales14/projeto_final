##### REGRESSAO, FIGURAS E TABELAS
## TALES MARTINS - 30/10/2019

## PACOTES
library(tidyverse)
library(broom)

### IMPORTANDO BANCO DE DADOS LIMPOS ----------------------------------
ms <- read.csv("data/processed/dat_ms.csv")

## TESTE DE CORRELACAO ENTRE O INVESTIMENTO EM EDUCACAO E O IDH -------
cor.test(ms$edu, ms$idh)

## MODELO DE ANCOVA ---------------------------------------------------
fit <- lm (idh ~ edu * country, data = ms)
summary(fit)
anova(fit)

#### CRIANDO E SALVANDO AS TABELAS ------------------------------------
tab_s <- tidy(summary(fit))
tab_a <- tidy(anova(fit))
write.csv(tab_s, file = "outputs/tables/summary.csv", row.names = F)
write.csv(tab_a, file = "outputs/tables/anova.csv", row.names = F)

#### CRIANDO A FIGURA -------------------------------------------------
fig1 <- 
  ggplot(ms, aes(x = edu, y = idh, color = country)) +
  geom_point(size = 2) +
  stat_smooth(method = lm, aes(fill = country), alpha = .3) +
  labs(x = "Investimento em educação primária (% de GDP por estudante)",
       y = "Índice de Desenvolvimento Humano (IDH)") +
  theme_classic(base_size = 20)

### SALVANDO A FIGURA -------------------------------------------------
ggsave(fig1,filename = "outputs/figures/01_FIG.png", 
       width = 12, height = 9)

