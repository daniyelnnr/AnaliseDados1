#install.packages("shiny")
#install.packages("ggplot2")
#install.packages("dplyr")
#install.packages("plotly")
#install.packages("readr")
library(shiny)
library(dplyr, warn.conflicts = F)
library(ggplot2)
library(plotly)
library(readr)
#theme_set(theme_bw())

#Realizando a leitura dos dados
series_from_imdb <- read_csv("https://raw.githubusercontent.com/nazareno/imdb-series/master/data/series_from_imdb.csv")
#Selecionamos os dados das séries que iremos trabalhar
selected_series <- series_from_imdb %>% 
  filter(series_name %in% c("Breaking Bad", "Dexter", "Friends", "How I Met Your Mother", "Black Mirror",
                            "House of Cards", "Dexter", "Sense8", "Daredevil", "Homeland",
                            "Orphan Black", "Game of Thrones")) %>%
  select(series_name, Episode, series_ep, season, season_ep, UserRating, UserVotes)

shinyServer(function(input, output, session) {

  output$plotSerie = renderPlot({
    #Seleciona os últimos episódios de cada temporada
    last_ep_season <- selected_series %>%
      filter(series_name %in% c(input$seriesTitle)) %>%
      group_by(series_name, season) %>%
      slice(which.max(season_ep))
    
    #plot
    
    selected_series %>%
      filter(series_name %in% c(input$seriesTitle)) %>%
      ggplot(aes(x = series_ep, y = UserRating, colour=factor(season), size = UserVotes)) +
      geom_point() +
      geom_point(data = last_ep_season, aes(x = series_ep, y = UserRating, size = UserVotes), colour = "red") +
      labs(col = "Temporadas") +
      xlab("Nº do Episódio") + ylab("Avaliação do Usuário")
    
    # s <- selected_series %>%
    #   filter(series_name %in% c(input$seriesTitle)) %>%
    #   ggplot(aes(x = series_ep, y = UserRating, colour=factor(season), size = UserVotes)) +
    #   geom_point(aes(text = paste(
    #     "Nome do episódio:", Episode, "<br>",
    #     "Avaliação do episódio:", UserRating, "<br>",
    #     "Nº do episódio:", series_ep, "<br>",
    #     "Nº da temporada:", season, "<br>",
    #     "Votos do episódio:", UserVotes)
    #   )) +
    #   geom_point(data = last_ep_season, aes(x = series_ep, y = UserRating, size = UserVotes,
    #                                         text = paste(
    #                                           "Nome do episódio:", Episode, "<br>",
    #                                           "Avaliação do episódio:", UserRating, "<br>",
    #                                           "Nº do episódio:", series_ep, "<br>",
    #                                           "Nº da temporada:", season, "<br>",
    #                                           "Votos do episódio:", UserVotes)), colour = "red") +
    #   labs(col = "Temporadas") +
    #   xlab("Nº do Episódio") + ylab("Avaliação do Usuário") +
    #   ggtitle("Avaliação do último episódio de cada temporada")
    # #theme_minimal()
    # ggplotly(s, tooltip = c("text")) %>%
    #   layout(autosize = T, width = 800, height = 700, margin = list(l = 50, r = 150, b = 100, t = 100, pad = 4))
    
    # x <- c("Título","Avaliação", "Nº Episódio na Temporada", "Nº de Votos", "r10")
    # y <- sprintf("{point.%s}", c("Episode", "UserRating", "season_ep", "UserVotes", "r10"))
    # tooltip <- tooltip_table(x, y)
    # 
    # last_ep_season <- selected_series %>%
    #   filter(series_name %in% c(input$seriesTitle)) %>%
    #   group_by(series_name, season) %>%
    #   slice(which.max(season_ep))
    # 
    # plot_series <- selected_series %>%
    #   filter(series_name %in% c(input$seriesTitle)) %>%
    #   hchart("scatter", hcaes(x = series_ep, y = UserRating, group = season, size = UserVotes)) %>%
    #   hc_title(text = "Avaliações por temporada") %>%
    #   hc_subtitle(text = "Tamanho indica votos do episódio") %>%
    #   #hc_add_series_scatter(last_ep_season, series_ep, UserRating, color = "red") %>%
    #   hc_tooltip(useHTML = TRUE, headerFormat = "", pointFormat = tooltip)
    # plot_series
    
  })
  
  # output$plotSerieBySeason = renderPlot({
  #   
  #   last_ep_season <- selected_series %>%
  #     filter(series_name %in% c(input$seriesTitle), season >= input$MinSerieSeason, season <= input$MaxSerieSeason) %>%
  #     group_by(series_name, season) %>%
  #     slice(which.max(season_ep))
  #   
  #   #plot
  #   
  #   plot <- selected_series %>%
  #     filter(series_name %in% c(input$seriesTitle), season >= input$MinSerieSeason, season <= input$MaxSerieSeason) %>%
  #     ggplot(aes(x = series_ep, y = UserRating, colour=factor(season), size = UserVotes)) +
  #     geom_point() +
  #     geom_point(data = last_ep_season, aes(x = series_ep, y = UserRating, size = UserVotes), colour = "red") +
  #     labs(col = "Temporadas") +
  #     xlab("Nº do Episódio") + ylab("Avaliação do Usuário")
  #   plot
  #   
  #   # output$minSeason <- min(plot$season)
  #   # output$maxSeason <- max(plot$season)
  #   
  # })
  
})