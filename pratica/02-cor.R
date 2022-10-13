library(dados)
library(tidyverse)

p1 <- dados_starwars |> 
  filter(massa < 1000) |> 
  ggplot() +
  aes(x = massa, y = altura, color = sexo_biologico) +
  geom_point(size = 3) +
  theme_minimal()

p1



p2 <- dados_starwars |> 
  filter(massa < 1000) |> 
  ggplot() +
  aes(x = massa, y = altura, color = log10(ano_nascimento)) +
  geom_point(size = 3) +
  theme_minimal()

p2

# parenteses
# p1 |> readr::write_rds("grafico_altura_massa.rds")


# discretas


p1 +
  scale_color_brewer(palette = "Set2")

p1 +
  scale_color_brewer(palette = "Set2", direction = -1)

p1 +
  scale_color_brewer(palette = "Set2", na.value = "#808080")

p1 +
  scale_color_viridis_d()


p1 +
  scale_color_viridis_d(option = "D",
                        begin = 0.2,
                        end = 0.8,
                        na.value = "#808080")


p1 +
  scale_color_manual(values = c("#8034D9", "#32ABFA", "#D99434"))

# continuas

p2 +
  scale_color_distiller(palette = "YlOrRd", direction = 1)

p2 +
  scale_color_fermenter(palette = "BuGn", direction = 1)

p2 +
  scale_color_viridis_c()

p2 + 
  scale_color_viridis_b(direction = -1)



# pacotes com temas!!

p1 +
  scale_color_brewer(palette = "Set2") +
  ggthemes::theme_fivethirtyeight()


p1 +
  scale_color_brewer(palette = "Set2") +
  ggthemes::theme_solarized()


p1 +
  ggthemes::scale_color_fivethirtyeight() +
  ggthemes::theme_fivethirtyeight()


# tv themes

p1 +
  tvthemes::scale_color_simpsons() +
  tvthemes::theme_simpsons()

# install.packages("devtools")
# devtools::install_github("brunomioto/ggimprensa")



p1 +
  labs(title = "exemplo") +
  ggimprensa::tema_poder360()
