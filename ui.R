library(shiny)
library(ggplot2)
library(PKPDdatasets)
data(sd_iv_rich_pkpd)
dataset <- sd_iv_rich_pkpd

shinyUI(fluidPage(
  
  title = "PKPD Explorer",
  
  plotOutput('plot'),
  
  hr(),
  
  fluidRow(
    column(3,
           h4("PKPD Explorer"),
           sliderInput('numInds', 'Number of Individuals', 
                       min=1, max=length(unique(dataset$ID)),
                       value=length(unique(dataset$ID)), 
                       step=1, round=0),
           br(),
           checkboxInput('point', 'Point', value = TRUE),
           checkboxInput('line', 'Line'),
           checkboxInput('col_factor', 'Factor Color', value = TRUE),
           checkboxInput('log_y', 'log Y scale', value = FALSE)
    ),
    column(4, offset = 1,
           selectInput('x', 'X', names(dataset), "TIME" ),
           selectInput('y', 'Y', names(dataset), "COBS"),
           selectInput('color', 'Color', c('None', names(dataset)))
    ),
    column(4,
           selectInput('facet_row', 'Facet Row',
                       c(None='.', names(sd_iv_rich_pkpd))),
           selectInput('facet_col', 'Facet Column',
                       c(None='.', names(sd_iv_rich_pkpd))),
           selectInput('group', 'Group', c('None', names(dataset)), 
                       selected = 'ID')
    )
  )
))