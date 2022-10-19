library(tidyverse)
library(dados)
library(patchwork)

p1 <- dados_starwars |> 
  ggplot() +
  aes(x = massa, y = altura) + geom_point()

p2 <-  dados_starwars |> 
  count(genero) |> 
  ggplot() +
  aes(x = genero, y = n) + 
  geom_col()


p3  <-  dados_starwars |> 
  count(sexo_biologico) |> 
  ggplot() +
  aes(x = sexo_biologico, y = n) + 
  geom_col()

p4  <-  dados_starwars |> 
  ggplot() +
  aes(x = massa) + 
  geom_histogram()




p1 + p2 + plot_annotation(tag_levels = "A")

# funcao do r base que funciona de forma similar, argumentos mfcol, mfrow
?par()


p1 + p2 + p3 + p4

layout <- "
AAAAAA
AAAAAA
BBCCDD
##CCDD
"


p1 + p2 + p3 + p4 + plot_layout(design = layout)



patchwork::wrap_plots(p1, p2)


