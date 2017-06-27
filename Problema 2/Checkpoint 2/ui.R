# install.packages("shiny")
# install.packages("ggplot2")
library(shiny)
library(ggplot2)

shinyUI(
  fluidPage(
    theme = "bootstrap.css",
    h3("Últimos episódios por temporada de cada série", align = "center"),
    p(""),
    p(""),
    p("O gráfico abaixo mostra os episódios de uma determinada série, destacando em vermelho o último episódio de cada temporada. 
      O tamanho de cada ponto aumenta de acordo com a quantidade de avaliações de um determinado episódio.
      Dessa forma, podemos observar que nem sempre o último episódio é o mais bem avaliado em uma temporada!
      \n"),
    
    
    sidebarLayout(
      sidebarPanel(
        selectInput("seriesTitle",
                    "Escolha a série a ser observada: ", 
                    c("Breaking Bad", "Dexter", "Friends", "How I Met Your Mother", "Black Mirror",
                      "House of Cards", "Dexter", "Sense8", "Daredevil", "Homeland",
                      "Orphan Black", "Game of Thrones")
        )
      ),
      mainPanel(
        plotOutput(outputId = "plotSerie", hover = "hover")
      )
    )
    # ,
    # 
    # sidebarLayout(
    #   sidebarPanel(
    #     selectInput("MinSerieSeason",
    #                 "Min Temporada",
    #                 c(1,2,3,4)
    #     )
    #   ),
    #   mainPanel(
    #     plotOutput(outputId = "plotSerieBySeason", hover = "hover")
    #   )
    # )
    
  )
)