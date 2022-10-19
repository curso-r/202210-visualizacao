library(tidyverse)
library(dados)
library(gganimate)


?dados_gapminder

grafico_animado <- dados_gapminder |> 
  #mutate(exemplo_glue = glue::glue("A população no país {pais} em {ano} era de {populacao/1000} mil habitantes")) |>
  ggplot() +
  aes(x = expectativa_de_vida, y = log10(pib_per_capita)) +
  geom_point(aes(size = log10(populacao))) +
  facet_wrap(~continente) +
  theme_minimal() +
  # gg_animate
  labs(x = "Expectativa de vida",
       y = "log10(Pib per capita)",
       title = "Ano: {frame_time}") +
 gganimate::transition_time(time = ano)
  

dados_gapminder$ano |> unique()

grafico_animado

gganimate::animate(
  grafico_animado,
  nframes = 40,
  duration = 10,
  start_pause = 2,
  end_pause = 2,
  width = 800,
  height = 400,
  renderer = gganimate::gifski_renderer("pratica/video_gganimate.gif")
)
