ui <- fluidPage(
  titlePanel("1. Réseau Ferroviaire Français"),
  HTML("On peut tout d'abord visualiser la distribution des limitations de vitesse sur tous les tronçons de lignes de train en France via l'histogramme."),
  
  # Affichage de l'histogramme
    
  # Slider
  sliderInput(
    inputId = "plage_vitesses",
    label = "Sélectionnez la plage de vitesse :",
    min=min(shapes_speeds$v_max),
    max = max(shapes_speeds$v_max),  
    value = c(min(shapes_speeds$v_max), max(shapes_speeds$v_max)),
    step = 1  # Incrément du slider
  ),
  
  plotOutput(outputId="reseau_histogram"),

  HTML("
        On constate que la majorité des tronçons de lignes sont à faible vitesse (&lt; 150 km/h).<br>
        Il est important de noter que le nombre de tronçons de lignes à grande vitesse est très faible, mais qu'ils représentent la moitié du réseau ferroviaire français, car ils sont plus longs que les tronçons lents.<br>
        On peut le voir en regardant la carte ci-dessous en jouant avec les boutons radio.<br><br>

        On peut également visualiser la carte du réseau ferroviaire français, avec les gares les plus fréquentées (&gt; 5 millions de voyageurs en 2023) et la vitesse maximale sur chaque tronçon de ligne.<br>
        Pour des raisons de clarté, on ne montre pas les gares de l'île de France, qui sont de loin les plus fréquentées (voir le scatterplot ci-dessous).
  "),

  # Affichage de la carte
  leafletOutput("reseau_map"),

  HTML("
        On remarque que la zone où le réseau est le plus dense est l'Île-de-France, car Paris est le hub de transport français (il n'existe pas de ligne TGV directe entre Montpellier et Marseille par exemple).<br>
        Les zones où le réseau est le moins exploité par les TGV sont le Massif Central, les Pyrénées, et le Grand Est.<br><br>

        Le statut de hub de transport de Paris est également visible sur le pie chart ci-dessous, qui montre la répartition en nombre de voyageurs des gares à forte affluence (&gt; 5M voyageurs) par région en 2023.
  "),

  # Affichage du piechart et du scatterplot
  fluidRow(
    column(6, plotOutput(outputId = "reseau_piechart")),
    column(6, plotOutput(outputId = "reseau_scatterplot"))
  ),
  
  HTML("
        On peut directement identifier que les plus grandes gares de France sont en île de France. Il s'agit de Paris Gare de Lyon, Paris Montparnasse, Paris Saint-Lazare et Paris Gare du Nord.<br>
        Paris domine donc largement le réseau ferroviaire français, et la plupart des gares à fort trafic sont situées en Île-de-France.
  "),
  
  titlePanel("2. Évolution du nombre de voyageurs dans le temps (2015-2023)"),
  
  HTML("Ce graphique montre l'évolution du nombre total de voyageurs par région pour chaque année entre 2015 et 2023."),
  
  checkboxInput("checkbox_idf", "Inclure l'Île de France ?", value = FALSE),
  
  plotOutput(outputId="covid_line_plot"),
  
  HTML("
        On peut voir que la région Île-de-France est de loin la plus fréquentée, suivie par Auvergne-Rhône-Alpes et les Hauts de France.<br>
        On constate également une baisse significative du nombre de voyageurs en 2020, probablement due à la pandémie de COVID-19.<br><br>

        On peut chercher à voir quelles sont les régions les plus impactées par la pandémie. Ce graphique montre la part des voyageurs perdus entre 2019 et 2020 par région en points de pourcentage.
  "),
  
  plotOutput(outputId="covid_bar_chart"),
  
  HTML("
        On peut voir que la région Île-de-France est de loin la plus impactée par la pandémie, avec plus de 50% de perte de voyageurs.<br>
        Cela témoigne de l'importance qu'a la région Île-de-France dans le réseau ferroviaire français, en tant que hub de transport, autant dans le trafic qu'elle reçoit que dans les pertes que peut engendrer une situation de crise.
  "),

)