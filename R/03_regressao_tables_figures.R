##### REGRESSAO, FIGURAS E TABELAS

## PACOTES
library(tidyverse)

### IMPORTANDO BANCO DE DADOS LIMPOS E SELECIONANDO OS DADOS DO BRASIL
dat <- read.csv("data/processed/dat.csv")
br <- filter(dat, country %in% "Brazil")

## TESTE DE CORRELACAO ENTRE O INVESTIMENTO EM EDUCACAO E O IDH
cor.test(br$edu, br$idh)

## MODELO LINEAR
fit <- lm (idh ~ edu, data = br)
summary(fit)
anova(fit)

#### CRIANDO AS TABELAS
tab_s <- broom::tidy(summary(fit)) 
tab_a <- broom::tidy(anova(fit))
write.csv(tab_s, file = "outputs/tables/summary.csv", row.names = F)
write.csv(tab_a, file = "outputs/tables/anova.csv", row.names = F)

#### CRIANDO AS FIGURAS
fig1 <- 
  ggplot(br, aes(x = edu, y = idh)) +
  geom_point(size = 4) +
  geom_abline(intercept = 0.6387557, slope = 0.0045467, lwd = 1) +
  scale_x_continuous(limits = c(10, 22), breaks = seq(10,22,2)) +
  scale_y_continuous(limits = c(0.6, 0.8), breaks = seq(0.6,0.8,0.05)) +
  labs(x = "Investimento em educação primária (% de GDP por estudante)",
       y = "Índice de Desenvolvimento Humano (IDH)") +
  theme_classic(base_size = 20)

### SALVANDO AS FIGURAS
ggsave(fig1,filename = "outputs/figures/01_FIG.png", width = 12, height = 9)

