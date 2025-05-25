generate_reseau_histogram <- function(shapes_speeds) {
  # Créer l'histogramme
  ggplot(shapes_speeds, aes(x = v_max)) +
    geom_histogram(
      bins = 50,
      fill = "cyan",
      color = "black"
    ) +
    labs(
      title = "Vitesse maximale sur chaque tronçon de ligne",
      x = "Vitesse (km/h)",
      y = "Nombre de tronçons"
    )
}

generate_reseau_map <- function(shapes_speeds, gares_communes) {
  # On ajoute les gares
  gares_les_plus_frequentees_2023 <- gares_communes %>%
    filter(Total.Voyageurs > 5000000, Année == 2023, nom_region != "Île-de-France")
  # On ne prend que les gares dont la fréquentation était supérieure à 5 millions de voyageurs en 2023.
  # Pour plus de clareté, on enlève les gares hors de l'île de France
  
  #Pour simplifier la lecture, on ajoute 2 colonnes Lat et Lon (latitude et longitude)
  # Ligne empruntée de https://stackoverflow.com/questions/47661354/converting-geometry-to-longitude-latitude-coordinates-in-r
  gares_les_plus_frequentees_2023 <- gares_les_plus_frequentees_2023 %>%
    extract(geometry, into = c('Lon','Lat'), '\\((.*),(.*)\\)', convert = TRUE)
  
  # On ajoute une colonne pour le popup
  gares_les_plus_frequentees_2023$popup <- paste0(
    "<strong>", gares_les_plus_frequentees_2023$libelle, "</strong><br/>",
    "Voyageurs en 2023 : ", format(gares_les_plus_frequentees_2023$Total.Voyageurs, big.mark = " ")
  )
  
  # Palette de couleurs pour les tronçons
  pal <- colorNumeric(
    palette = "viridis",  
    domain = c(20,350) # Il s'agit de la plage des vitesses possibles
  )
  
  # On crée la carte de base
  fig <- leaflet() %>%
    addTiles() %>%
    setView(lng = 2.430331, lat = 46.539758, zoom = 5)
  
  fig <- fig %>%
    addCircleMarkers(
      data = gares_les_plus_frequentees_2023,
      lng = ~Lon, 
      lat = ~Lat,
      radius = ~Total.Voyageurs / 1000000, 
      color = "blue",
      stroke = FALSE,
      fillOpacity = 0.7,
      popup = ~popup
    ) %>%
    addPolylines(
      data = shapes_speeds,  
      color = ~pal(v_max),   
      weight = 2,
      opacity = 0.8,
      label = ~paste("v_max:", v_max)
    ) %>%
    addLegend(
      position = "bottomright",
      pal = pal,
      values = shapes_speeds$v_max,
      title = "Vitesse max (km/h)",
      opacity = 1
    )
  
  fig
}

generate_reseau_piechart <- function(gares_communes) {
  # Filtrer les gares avec plus de 5M de voyageurs en 2023
  gares_les_plus_frequentees_2023 <- gares_communes %>%
    filter(`Total.Voyageurs` > 5000000, Année == 2023)
  
  # On compte le nombre de gares à forte affluence dans chaque région
  region_counts <- gares_les_plus_frequentees_2023 %>%
    count(nom_region, name = "Nombre_de_gares_a_fort_trafic")%>%
    na.omit() 
  
  # Solution inspirée de https://r-graph-gallery.com/piechart-ggplot2.html
  ggplot(region_counts, aes(x = "", y = Nombre_de_gares_a_fort_trafic, fill = nom_region)) +
    geom_col(color = "white") +
    coord_polar(theta = "y") +
    theme_void() +
    labs(title = "Répartition des gares à forte affluence (> 5M voyageurs) par région (2023)") +
    theme(legend.title = element_blank())
}
  
generate_reseau_scatterplot <- function(gares_communes) {
  gares_les_plus_frequentees_2023 <- gares_communes %>%
    filter(Année == 2023 & Total.Voyageurs > 5000000 & !is.na(nom_region))
    
  # Création du scatterplot
  ggplot(gares_les_plus_frequentees_2023, aes(x = PTOT, y = Total.Voyageurs, color = nom_region, label = libelle)) +
    geom_point() +
    labs(
      title = "Gares à fort trafic (> 5M voyageurs) : fréquentation vs population de la commune (2023)",
      x = "Population totale",
      y = "Total Voyageurs",
      color = "Région"
    )
}
