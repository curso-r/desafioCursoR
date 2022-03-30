library(shiny)

# Ui ----------------------------------------------------------------------

ui <- fluidPage(


  h2("Curso R - Desafio 2: Botão de contagem em Shiny"),
  h3("Autor: Maykon G. Pedro"),
  sidebarLayout(

    sidebarPanel = sidebarPanel(

      #  input -> botão para clicar
      actionButton(
        inputId = "botao",
        label = "Clique aqui",
        class = "btn-success"
      )

    ),

    mainPanel = mainPanel(
      # output de texto
      htmlOutput(outputId = "texto")
    )
  )

)

# Server ------------------------------------------------------------------

server <- function(input, output, session) {

  # contador para cada vez que o botão é clicado
  contador <- reactiveVal(0)

  # tempo entre as contagens
  time <- reactiveVal()

  observeEvent(
    input$botao, {

      # contador
      cont <- contador() # recebe o valor reativo
      contador(cont + 1) # atualiza pra cada vez que o botão é clicado

      # tempo
      time(capture.output(tictoc::toc()))
      tictoc::tic()

      # condição
      # necessário usar o shiny::req para não estourar erro na primeira rodada
      if (req(time()) > 2) {

        contador(0)
        # print("passei por aqui")
      }

    }
  )

  # output -> contador que imprime os cliques
  output$texto <- renderUI({

    shiny::HTML(

      paste0(
        "Quantidade de vezes que você clicou no botão: ",
        "<b>", contador(), "</b>",
        "<br/>",
        "Tempo entre cliques: ",
        "<b>", time(), "</b>"
      )
    )

  })

}

shinyApp(ui, server)
