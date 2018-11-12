install.packages("devtools")
devtools::install_github("lizhongliu1996/dotaRecord")
library(shiny)
library(dotaRecord)




ui <- fluidPage(

  h1("This is a shiny webpage to get your dota2 information!"),
  p("you can input your match ID or your dota2 ID"),


  textInput("matchID", label = h3("Please input match ID"), value = NULL),
  submitButton("confirm", icon("confirm")),
  verbatimTextOutput("match"),

  textInput("dota2ID", label = h3("Please input your dota2 account ID"), value = NULL ),
  submitButton("confirm", icon("confirm")),
  verbatimTextOutput("account"),

  mainPanel(
    fluidRow(
      column(12, textOutput("match_wins"),style="color:red;font-size: 50px") # notice the ,
    ), #end of this fluidRow notice comma needed before the next fluidRow()

    fluidRow(
      column(12, dataTableOutput('match_detail')) # notice the ,
    ), #end of this fluidRow notice comma needed before the next fluidRow()

    fluidRow(
      column(8, plotOutput("WinLosePlot", height = 380)),
      column(4, textOutput("mmr"),style="font-size: 30px")# notice the ,
    ), #end of this fluidRow notice comma needed before the next fluidRow()
    fluidRow(
      column(6, plotOutput("RadiantPlot", height = 320)),
      column(6, plotOutput("DirePlot", height = 320)) # notice the ,
    ), #end of this fluidRow notice comma needed before the next fluidRow()
    fluidRow(
      column(12, plotOutput("HeroRankPlot", height = 650)) # notice the ,
    ) #end of this fluidRow notice comma needed before the next fluidRow()

  )  # end of mainPanel

) #end of ui

server <- function(input, output, session) {
  dotaid <- reactive({
    req(input$dota2ID)
    input$dota2ID
  })

  matchid <- reactive({
    req(input$matchID)
    input$matchID
  })

  output$match <- renderText({
    paste("the match ID is ", input$matchID)
  }) #end matchid renderText

  output$match_detail <- renderDataTable(
    match_details(matchid())
  ) #end match_details renderTable

  output$match_wins <- renderText(
    paste(match_wins(matchid()))
  ) #end match_wins renderText

  output$mmr <- renderText({
    paste("Your game ID is " ,
        unlist(get_mmr(dotaid())["GameID"]),
        "with mmr score ",
        get_mmr(dotaid())["MMR_score"]
        )
  })

  output$account <- renderText({
    paste("the dota2 account ID is ", input$dota2ID)
  }) #end dota2id renderText

  output$WinLosePlot <- renderPlot(
    win_lose_plot(dotaid())
  ) #end winlose renderPlot

  output$RadiantPlot <- renderPlot(
    radiant_plot(dotaid())
  ) #end radiantwin renderPlot

  output$DirePlot <- renderPlot(
    dire_plot(dotaid())
  ) #end direwin renderPlot

  output$HeroRankPlot <- renderPlot(
    hero_rank(dotaid())
  ) #end herorank renderPlot



} #end of server

shinyApp(ui, server)
