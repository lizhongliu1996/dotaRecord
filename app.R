library(shiny)
library(dotaRecord)




ui <- fluidPage(

  h1("This is a shiny webpage to get your dota2 information!"),
  p("you can input your match ID or your 9 digit dota2 ID"),

  textInput("matchID", label = h3("Please input match ID"), value = NULL),
  submitButton("confirm", icon("confirm")),
  verbatimTextOutput("match"),

  textInput("dota2ID", label = h3("Please input your dota2 account ID"), value = NULL ),
  submitButton("confirm", icon("confirm")),
  verbatimTextOutput("account"),

  mainPanel(
    column(5, plotOutput("WinLosePlot", height = 250)),
    column(5, plotOutput("RadiantPlot", height = 250)),
    column(5, plotOutput("DirePlot", height = 250)),
    column(8, plotOutput("HeroRankPlot", height = 300))
    )  # end of mainPanel

) #end of ui

server <- function(input, output, session) {
  dotaid <- reactive({
    req(input$dota2ID)
    input$dota2ID
  })

  output$match <- renderText({
    paste("the match ID is ", input$matchID)
  }) #end matchid renderText

  output$account <- renderText({
    paste("the dota2 account ID is ", input$dota2ID)
  }) #end dota2id renderText

  output$WinLosePlot <- renderPlot(
    win_lose_plot(dotaid())
  )

  output$RadiantPlot <- renderPlot(
    radiant_plot(dotaid())
  )

  output$DirePlot <- renderPlot(
    dire_plot(dotaid())
  )

  output$HeroRankPlot <- renderPlot(
    hero_rank(dotaid())
  )


} #end of server

shinyApp(ui, server)
