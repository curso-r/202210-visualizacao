library(readr)
library(tidyverse)
actions_runs <- read_csv("https://github.com/curso-r/202210-visualizacao/blob/main/dados/actions_runs.csv?raw=true")

class(actions_runs$run_started_at)


base_contagem <- actions_runs |>
  mutate(
    mes = lubridate::floor_date(run_started_at, "month"),
    mes = as.Date(mes)
  ) |>
  filter(conclusion != "skipped", mes <= "2022-06-01") |> 
  count(mes)
  
  
grafico_base <- base_contagem |> 
  ggplot() +
  aes(x = mes, y = n) +
  geom_line(size = 1.5, color = "#80868b")
  

# parenteses - criando uma funcao
colar_k <- function(x){
  paste0(x / 1000, "k")
}

colar_k(10000)


mes_min_max <- base_contagem |> 
  filter(mes %in% c(min(mes), max(mes))) |> 
  mutate(legenda = paste0(round(n/1000), "k"),
         mes = as.Date(mes))


grafico_final <- grafico_base +
  theme_minimal(base_size = 12) +
  scale_x_date(date_labels = "%b/%y", 
               date_breaks = "4 month",
               limits = c(as.Date("2020-04-01"), as.Date("2022-06-01"))) +
  scale_y_continuous(limits = c(0, 20000),
                     labels = function(x){paste0(x/1000, "k")}) +
  labs(
    y = "Actions runs per month",
    x = "",
    title = "Actions runs by RStudio/Posit organizations on GitHub",
    caption = "Plot made by @BeaMilz. Data from the GitHub API."
  ) +
  geom_point(
    data = mes_min_max,
    aes(x = mes, y = n),
    size = 3,
    color = "#4c83b6"
  ) +
  ggrepel::geom_text_repel(
    data = mes_min_max,
    aes(x = mes, y = n, label = legenda),
    size = 8,
    color = "#4c83b6",
    nudge_y = 4000,  family = "Verdana"
  ) + 
  theme(
    plot.title.position = "plot",
    panel.grid.minor = element_blank(),
    panel.grid.major = element_blank(),
    text = element_text(
      color = "#80868b", family = "Verdana"
    ),
    plot.title = element_text(size = 14)
  )


ggsave("pratica/img_otimizacao_visual.png")
  


grafico_base +
  scale_y_continuous(labels = function(numero){paste0("R$ ", numero)})
  
