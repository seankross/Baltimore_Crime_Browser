library(shiny)
library(shinydashboard)
library(leaflet)

dashboardPage(
  dashboardHeader(title = "Baltimore Crime Browser", titleWidth = 250),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Map of Baltimore", tabName = "map", icon = icon("map")),
      menuItem("Graphs & Metrics", tabName = "graphs", icon = icon("signal", lib = "glyphicon")),
      menuItem("About", tabName = "about", icon = icon("question-circle")),
      menuItem("Source Code", href = "http://github.com/seankross/Baltimore_Crime_Browser", icon = icon("github-alt"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "map",
      fluidRow(
        column(width = 8,
               box(width = NULL,
                   leafletOutput("crime_map", height = 500))
        ),
        column(width = 3,
               box(width = NULL,
                   dateRangeInput("date1", "Select dates to visualize.",
                                  start = "2015-06-01", end = "2015-07-01",
                                  min = min(crime$CrimeDate), max = max(crime$CrimeDate))
               )
        )
      )
      ),
      tabItem(tabName = "graphs",
              fluidRow(
                column(width = 6,
                       box(width = NULL,
                           plotOutput("daily_plot"))),
                column(width = 6,
                       box(width = NULL,
                           plotOutput("desc_plot")))
              )),
      tabItem(tabName = "about")
    )
  )
)