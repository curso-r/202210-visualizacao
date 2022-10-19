library(ggridges)
library(tidyverse)
library(dados)

diamante |> View()

diamante |> 
  ggplot() +
  aes(x = preco, y = corte, fill = corte) +
  ggridges::geom_density_ridges(
    alpha = 0.7,
    quantile_lines = TRUE,
    quantiles = 2
  ) 

media_geral_preco <- mean(diamante$preco)

diamante |> 
  ggplot() +
  aes(x = preco, y = corte, fill = corte) +
  ggridges::geom_density_ridges(
    alpha = 0.7,
    quantile_lines = TRUE,
    quantiles = 2
  ) +
  geom_vline(xintercept = media_geral_preco,
             color = "gray", size = 1.5, linetype = 2) +
  theme_classic() +
  annotate(
    "text",
    x = media_geral_preco, 
    y = 6.5, 
    hjust = -0.1,
    label = glue::glue("Média: {scales::dollar(media_geral_preco)}"),
    size = 5
  ) +
  scale_x_continuous(labels = scales::dollar) +
  theme(legend.position = "none") +
  labs(x = "Preço", y = "Corte", title = "Preço de diamantes, segundo o corte")
  


