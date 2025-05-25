server <- function(input,output){
  
  output$reseau_histogram <- renderPlot({
    # Filtrage de shapes_speeds pour répondre au slider
    filtered_shapes_speeds <- shapes_speeds %>%
      filter(v_max >= input$plage_vitesses[1] & v_max <= input$plage_vitesses[2])
    
    generate_reseau_histogram(filtered_shapes_speeds)
  })
  
  output$reseau_map <- renderLeaflet({
    if (input$reseau_radio == "Lignes à faible vitesse (< 100 km/h)"){
      shapes_speeds_filtered <- shapes_speeds %>%
        filter(v_max < 100)
    }
    else if (input$reseau_radio == "Lignes à grande vitesse (>= 100 km/h)"){
      shapes_speeds_filtered <- shapes_speeds %>%
        filter(v_max >= 100)
    }
    else {
      shapes_speeds_filtered <- shapes_speeds
    }
    generate_reseau_map(shapes_speeds_filtered,gares_communes)
  })
  
  output$reseau_piechart <- renderPlot(generate_reseau_piechart(gares_communes))
  
  output$reseau_scatterplot <- renderPlot(generate_reseau_scatterplot(gares_communes))
  
  output$covid_line_plot <- renderPlot(
    generate_covid_line_plot(gares_communes,with_idf = input$checkbox_idf)
  )
  
  output$covid_bar_chart <- renderPlot(
    generate_covid_bar_chart(gares_communes)
  )
}