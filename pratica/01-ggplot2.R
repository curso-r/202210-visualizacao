library(tidyverse)
# install.packages("dados")
library(dados)


# 1) passar os dados

View(dados_starwars)

dados_starwars |> 
  # fazer alguma manipulacao
  ggplot()


ggplot(dados_starwars)

# 2) Mapeamento estético
dados_starwars |> 
  ggplot() +
  aes(x = massa, y = altura)


dados_starwars |> 
  ggplot() + 
  aes(x = massa, y = altura)

dados_starwars |> 
  ggplot(aes(x = massa, y = altura))

# formas geométricas

dados_starwars |> 
  ggplot() +
  aes(x = massa, y = altura) +
  geom_point()


# Error in `validate_mapping()`:
#   ! `mapping` must be created by `aes()`
# Did you use %>% instead of +?


# geoms individuais - geom_point() - representa uma 
# linha da base

# geoms agrupados - representam um resumo

# geom point
# dentro do aes - colunas da base de dados
dados_starwars |> 
  filter(massa < 1000) |> 
  ggplot() +
  aes(x = massa, y = altura, color = sexo_biologico) +
  geom_point()


# fora do aes - não depende da base
dados_starwars |> 
  filter(massa < 1000) |> 
  ggplot() +
  geom_point(aes(x = massa, y = altura), color = "royalblue")



# diferença entre colocar o aes dentro e fora de um geom
dados_starwars |> 
  filter(massa < 1000) |> 
  ggplot() +
  geom_point(aes(x = massa, y = altura), color = "royalblue") +
  geom_point() # dá erro!


dados_starwars |> 
  filter(massa < 1000) |> 
  ggplot() +
  aes(x = massa, y = altura) +
  geom_point(color = "royalblue", size = 4) +
  geom_point(color = "red") # dá erro!


### geom_col e geom_bar


# geom_bar faz uma contagem
dados_starwars |> 
  ggplot() +
  aes(x = sexo_biologico) +
  geom_bar()

# geom_col não faz a contagem
dados_starwars |> 
  count(sexo_biologico, name = "qtd") |> 
  ggplot() +
  aes(x = sexo_biologico, y = qtd) +
  geom_col()


# linhas

voos |> 
  count(mes) |> 
  ggplot() +
  aes(x = mes, y = n) +
  geom_line() +
  scale_y_continuous(limits = c(0, 30000))


voos |> 
  count(mes, origem) |> 
  ggplot() +
  aes(x = mes, y = n, color = origem) +
  geom_line() #+
#scale_y_continuous(limits = c(0, 30000))


# histograma e density - distribuicao

dados_starwars |> 
  ggplot() +
  aes(x = altura) + 
  geom_histogram(binwidth = 10)


dados_starwars |> 
  ggplot() +
  aes(x = altura) + 
  geom_density()

dados_starwars |> 
  ggplot() +
  aes(x = altura, fill = genero) + 
  geom_density(alpha = 0.8)


# facet!

dados_starwars |> 
  ggplot() +
  aes(x = altura, fill = genero) + 
  geom_density(alpha = 0.8) +
  facet_wrap(vars(genero))


dados_starwars |> 
  ggplot() +
  aes(x = altura, fill = genero) + 
  geom_density(alpha = 0.8) +
  facet_wrap(~genero)



dados_starwars |> 
  ggplot() +
  aes(x = altura, fill = genero) + 
  geom_density(alpha = 0.8) +
  # cuidado para nao fazer comparacoes erradas!
  facet_wrap(vars(genero), scales = "free_y") 


# código gerado com esquisse!
library(dplyr)
library(ggplot2)

dados::dados_starwars %>%
 filter(!is.na(genero)) %>%
 ggplot() +
 aes(x = altura, y = massa, colour = genero) +
 geom_jitter(size = 1.5) +
 scale_color_brewer(palette = "Dark2", direction = -1) +
 labs(title = "Titulo") +
 ggthemes::theme_fivethirtyeight() +
 theme(legend.position = "top") +
 ylim(0, 200)




