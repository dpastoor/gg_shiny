library(shiny)
library(ggplot2)
library(PKPDmisc)
shinyServer(function(input, output) {
  
  dataset <- reactive({
    sd_iv_rich_pkpd[sd_iv_rich_pkpd$ID <= input$numInds,]
  })
  
  output$plot <- renderPlot({
    
    p <- ggplot(dataset(), aes_string(x=input$x, y=input$y, group = input$group))
    
    if (input$point)
      p <- p + geom_point()
    if (input$line)
      p <- p + geom_line()
    
    if (input$color != 'None')
      p <- p + aes_string(color=input$color)
    
    facets <- paste(input$facet_row, '~', input$facet_col)
    if (facets != '. ~ .')
      p <- p + facet_grid(facets)

    
    print(p + base_theme_obs())
    
  })
  
})