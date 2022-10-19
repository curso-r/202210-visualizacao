library(tidyverse)
library(dados)

# vamos fazer um bd de pokemons
pokemons <- c("pikachu", "bulbasaur", "squirtle", "charmander")
infos_pokemon <- function(pokemon) {
  u <- paste0("https://pokeapi.co/api/v2/pokemon/", pokemon)
  r <- httr::GET(u)
  j <- httr::content(r)
  tibble::tibble(
    pokemon = pokemon,
    attack = j$stats[[1]]$base_stat,
    img = j$sprites$front_default
  )
}

da_pokemon <- purrr::map_dfr(pokemons, infos_pokemon) |> 
  mutate(pokemon = fct_reorder(pokemon, attack)) |> 
  arrange(pokemon)


# TODO!