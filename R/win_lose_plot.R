#' win_lose_plot Helper function that draws a bar chart to
#' show your total winning rate when passed dota2 id
#'
#' @param dota2ID your dota2 account ID
#'
#' @return NULL
#' @import ggplot2 ROpenDota
#'
#' @export
#'
#' @examples
#' win_lose_plot(135474549)
#'
#'
#'
win_lose_plot<-function(dota2ID){
    ###total win
    win_lose<-count_player_win_lose(dota2ID)
    winlose <- data.frame(status=c("win", "lose"),
                     number=c(win_lose[[1]], win_lose[[2]]))

    p<-winlose[1,2]/(winlose[1,2]+winlose[2,2])
    roundp<-paste(round(100*p, 2), "%")

    titles<-c("Your total dota2 win/lose graph is below")
    subtitles<-paste("total winning rate is", roundp)
    status<-as.data.frame(winlose$status)
    number<-as.data.frame(winlose$number)

    ggplot(data=winlose, aes(x=status, y=number, fill= status)) +
      geom_bar(stat="identity")+
      labs(title = titles, subtitle = subtitles, x="Number",y="Status") +
      geom_text(aes(label=number), vjust=1.6, size=10) +
      guides(fill=FALSE) +
      theme(
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_rect(fill = "transparent",colour = NA),
        plot.background = element_rect(fill = "transparent",colour = NA)
      )





}
