generate_covid_line_plot <- function(gares_communes, with_idf = FALSE) {
  region_year_travelers <- gares_communes %>%
    group_by(Année, nom_region) %>%
    summarise(Total.Voyageurs = sum(Total.Voyageurs), .groups = 'drop') %>%
    filter(nom_region != "Île-de-France" | with_idf)
  
  ggplot(region_year_travelers, aes(x = Année, y = Total.Voyageurs, color = nom_region, group = nom_region)) +
    geom_line() +
    geom_point() +
    labs(
      x = "Année",
      y = "Total Voyageurs",
      color = "Région",
      title = "Nombre total de voyageurs par région (2015-2023)"
    ) 
}

generate_covid_bar_chart <- function(gares_communes) {
  # On filtre pour ne garder que les mesures de voyageurs de 2019 et 2002
  gares_communes_2019_2020 <- gares_communes %>%
    filter(Année == 2019 | Année == 2020)

  # Groupe par l'année et la région, et on fait la somme des voyageurs pour chaque région
  region_year_travelers <- gares_communes_2019_2020 %>%
    group_by(Année, nom_region) %>%
    summarise(Total.Voyageurs = sum(Total.Voyageurs, na.rm = TRUE)) %>%
    pivot_wider(names_from = Année, values_from = Total.Voyageurs) %>%
    filter(!is.na(nom_region))
  
  # On ajoute la colonne de la perte relative
  region_year_travelers_loss <- region_year_travelers %>%
    mutate(relative_loss = ((`2019` - `2020`) / `2019`) * 100)
  
  
  ggplot(region_year_travelers_loss, aes(x = reorder(nom_region, -relative_loss), y = relative_loss, fill = relative_loss)) +
    geom_col() +
    scale_fill_gradient(low = "blueviolet", high = "coral") +
    coord_flip()+
    labs(
      title = "Perte relative des voyageurs par région entre 2019 et 2020",
      x = "Région",
      y = "Perte relative (en %)",
      fill = "Perte relative"
    ) +
    theme_minimal()
}