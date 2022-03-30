library(shiny)

ui <- fluidPage(
  theme = bslib::bs_theme(version = 4),
  tags$head(
    tags$link(
      rel = "stylesheet",
      type = "text/css",
      href = "custom.css"
    )
  ),
  fluidRow(
    column(
      width = 6,
      class = "text-center",
      shinyWidgets::actionBttn(
        inputId = "botao",
        label = "Clique aqui",
        icon = icon("stopwatch"),
        style = "gradient",
        color = "warning"
      )
    ),
    column(
      width = 6,
      class = "text-center",
      uiOutput("total_cliques")
    )
  )
)

server <- function(input, output, session) {

  tempo <- reactiveVal(value = Sys.time())
  num_cliques <- reactiveVal(value = 0)

  observeEvent(input$botao, {
    novo_tempo <- Sys.time()
    tempo_entre_cliques <- novo_tempo - tempo()

    if (tempo_entre_cliques > 0.5) {
      num_cliques(1)
    } else {
      num_cliques(num_cliques() + 1)
    }

    tempo(novo_tempo)

  })

  output$total_cliques <- renderUI({
    tagList(
      p(class = "texto_cliques", "Cliques seguidos:"),
      p(class = "num_cliques", num_cliques())
    )
  })

}

shinyApp(ui, server)
