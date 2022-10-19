library(dados)
library(tidyverse)



grafico_personagens <- dados_starwars |> 
  ggplot() +
  aes(x = massa, y = altura) +
  geom_point()


jabba <- dados_starwars |> 
  filter(massa > 1000)

# função anotate() - anotação manual ------------------------------------
grafico_personagens +
  annotate(geom = "label",
           x = jabba$massa,
           y = jabba$altura,
           label = jabba$nome, 
           hjust = 0.8,
           vjust = 1.5,
           )



# geom_curve - seta -------------------------------------------------------



grafico_personagens +
  annotate(
    geom = "label",
    x = jabba$massa - 500,
    y = jabba$altura - 50,
    label = jabba$nome
  ) +
  geom_curve(
    data = jabba,
    aes(
      x = massa - 500,
      y = altura - 55,
      xend = massa - 5,
      yend = altura - 3
    ),
    arrow = arrow(type = "closed", length = unit(.5, "cm")),
    color = "red",
    curvature = 0.4
  )


# annotation_raster - imagem ----------------------------------------------


url_img <- "https://www.pikpng.com/pngl/b/277-2778885_jabba-the-hut-6-star-wars-black-series.png"

img <- url_img |> httr::GET() |> httr::content()


grafico_personagens +
  annotation_raster(raster = img,
                    xmin = jabba$massa - 400,
                    xmax = jabba$massa - 5,
                    ymin = jabba$altura - 50,
                    ymax = jabba$altura - 2
                    )


grafico_personagens +
  annotation_raster(raster = img,
                    xmin = 1000,
                    xmax = 1400,
                    ymin = 180,
                    ymax = 250
  ) +
  annotate(geom = "label",
           x = jabba$massa,
           y = jabba$altura,
           label = jabba$nome, 
           hjust = 0.8,
           vjust = 1.5,
  )



# gghighlight -------------------------------------------------------------



grafico_personagens +
  gghighlight::gghighlight(
    massa > 1000, label_key = nome
  )

grafico_personagens +
  gghighlight::gghighlight(
    altura > 225, label_key = nome
  )

grafico_personagens +
  gghighlight::gghighlight(
    altura < 100, label_key = nome, unhighlighted_params = list(
      color = "black", alpha = 0.5
    )
  )
  

# ggrepel -----------------------------------------------------------------

# geom_label comum:
dados_starwars |> 
  filter(massa < 1000) |> 
  ggplot() +
  aes(x = massa, y = altura) +
  geom_point() +
  geom_label(aes(label = nome))

#   ggrepel::geom_label_repel()
dados_starwars |> 
  filter(massa < 1000) |> 
  ggplot() +
  aes(x = massa, y = altura) +
  geom_point() +
  ggrepel::geom_label_repel(aes(label = nome), max.overlaps = 10)


# ggalt::geom_encircle ----------------------------------------------------

grafico_personagens +
  ggalt::geom_encircle(
    data = jabba,
    color = "red", 
    s_shape = 0,
    expand = 0,
    size = 2,
    spread = 0.02
  )

grafico_personagens +
  ggalt::geom_encircle(
    data = filter(dados_starwars, altura > 225),
    color = "blue", size = 2
  ) +
  ggalt::geom_encircle(
    data = filter(dados_starwars, altura < 100),
    color = "red", size = 2, expand = 0.04
  ) 



# usar junto! -------------------------------------------------------------

grafico_personagens +
  ggalt::geom_encircle(
    data = filter(dados_starwars, altura > 225),
    color = "blue", size = 2
  ) +
  ggalt::geom_encircle(
    data = filter(dados_starwars, altura < 100),
    color = "red", size = 2, expand = 0.04
  ) +
  annotate(geom = "text",
           x = 300,
           y = 255, color = "blue", size = 5,
           label = "Personagems com altura acima de 2.25m") +
  annotate(geom = "text",
           x = 360, 
           y = 105, color = "red", size = 5,
           label = "Personagems com altura abaixo de 1m") +
  theme_minimal()

  
