library(shiny)
library(plotly)
library(ggvis)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("Deaths Caused by US Drone Strike"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
       radioButtons('country','Country',
                    choices = c("Pakistan","Yemen","Somalia","Afghanistan","All"),
                    selected = "Pakistan"),
       radioButtons("casualty","Casualty Type",
                    choices = c("All People", "Civilians","Children","Combined"),
                    selected = "All People"),
       br(),
       h4("Usage Instructions"),
       p("This tools displays data collected from the Google Sheets provided by ",
         a("The Bureau of Investigative Journalism",
           href="https://www.thebureauinvestigates.com/category/projects/drones/drones-graphs/"),
         ", updated in real time. Use the Country radio buttons to select from the four
          countries available or all countries combined. Then use the Casualty Type
          radio buttons to select which category of casualty to show, or select
          Combined for all types overlaid on one graph.")
    ),

    # Show a plot of the generated distribution
    mainPanel(
      conditionalPanel(
        condition = "input.casualty == 'All People'", plotlyOutput("all_people_plot")),
      conditionalPanel(
        condition = "input.casualty == 'Civilians'", plotlyOutput("civilians_plot")),
      conditionalPanel(
        condition = "input.casualty == 'Children'", plotlyOutput("childrens_plot")),
      conditionalPanel(
        condition = "input.casualty == 'Combined'", plotlyOutput("combined_plot"))
    )
  )
))
