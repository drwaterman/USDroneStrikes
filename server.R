library(shiny)
library(plotly)
library(ggvis)

source("data_processing.R")
# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  dataInput <- reactive({
    switch(input$country,
           "Pakistan" = pak_plot_data,
           "Yemen" = yemen_plot_data,
           "Somalia" = som_plot_data,
           "Afghanistan" = afg_plot_data,
           "All" = all_plot_data)
  })

  output$all_people_plot <- renderPlotly({
    data = dataInput()
    plot_ly(x = ~data$date, y = ~data$people_killed, type = 'scatter',
            mode = 'lines', fill = 'tozeroy') %>%
        layout(xaxis = list(title = 'Month'),
               yaxis = list(title = 'Total People Killed'))
  })

  output$civilians_plot <- renderPlotly({
    data = dataInput()
    plot_ly(x = ~data$date, y = ~data$civilians_killed, type = 'scatter',
            mode = 'lines', fill = 'tozeroy') %>%
        layout(xaxis = list(title = 'Month'),
               yaxis = list(title = 'Civilians Killed'))
  })

  output$childrens_plot <- renderPlotly({
    data = dataInput()
    plot_ly(x = ~data$date, y = ~data$children_killed, type = 'scatter',
            mode = 'lines', fill = 'tozeroy') %>%
        layout(xaxis = list(title = 'Month'),
               yaxis = list(title = 'Children Killed'))
  })

  output$combined_plot <- renderPlotly({
    data = dataInput()
#    plot_ly(x = ~data$date, y = ~data$children_killed, type = 'scatter',
#            mode='lines', fill='tozeroy', fillcolor='#F5FF8D') %>%
#        layout(xaxis = list(title = 'Month'),
#               yaxis = list(title = 'Children Killed'))
    plot_ly(x = ~data$date, y = ~data$people_killed, name = 'Total People Killed',
            type='scatter', mode='lines', fill='tozeroy') %>%
      add_trace(y=~data$civilians_killed, name='Civilians Killed') %>%
      add_trace(y=~data$children_killed, name='Children Killed') %>%
      layout(title = 'All People Killed by Category',
             xaxis = list(title = "Month", showgrid = FALSE),
             yaxis = list(title = "Number Killed", showgrid = FALSE))

  })


})
