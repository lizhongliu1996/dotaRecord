library(shiny)
library(shinyWidgets)
library(dotaRecord)




ui <- fluidPage(
  tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "bootstrap.css")),

  setBackgroundImage(src = "dota_2.jpg"),

  h1("This is a shiny webpage to get your dota2 information!"),
  p("You can input your match ID or your dota2 ID"),


  textInput("matchID", label = h3("Please input match ID"), value = NULL),
  submitButton("confirm1", icon("confirm")),
  verbatimTextOutput("match"),

  textInput("dota2ID", label = h3("Please input your dota2 account ID"), value = NULL ),
  submitButton("confirm2", icon("confirm")),
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
      column(4, textOutput("mmr"),style="color:black;font-size: 30px")# notice the ,
    ), #end of this fluidRow notice comma needed before the next fluidRow()
    fluidRow(
      column(6, plotOutput("RadiantPlot", height = 320)),
      column(6, plotOutput("DirePlot", height = 320)) # notice the ,
    ), #end of this fluidRow notice comma needed before the next fluidRow()
    fluidRow(
      column(12, plotOutput("HeroRankPlot", height = 800)) # notice the ,
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
    paste("The match ID is ", matchid())
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
    paste("The dota2 account ID is ", dotaid())
  }) #end dota2id renderText

  output$WinLosePlot <- renderPlot({
    win_lose_plot(dotaid())
  },bg="transparent") #end winlose renderPlot

  output$RadiantPlot <- renderPlot({
    radiant_plot(dotaid())
    },bg="transparent") #end radiantwin renderPlot

  output$DirePlot <- renderPlot({
    dire_plot(dotaid())
  },bg="transparent") #end direwin renderPlot

  output$HeroRankPlot <- renderPlot({
    hero_rank(dotaid())
  },bg="transparent") #end herorank renderPlot



} #end of server

shinyApp(ui, server)
