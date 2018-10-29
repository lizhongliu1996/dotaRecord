
#' win_lose_plot Helper function that draws a bar chart when passed dota2 id
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
    win_lose<-count_player_win_lose(dota2ID)
    winlose <- data.frame(status=c("win", "lose"),
                     number=c(win_lose[[1]], win_lose[[2]]))

    p<-winlose[1,2]/(winlose[1,2]+winlose[2,2])
    roundp<-paste(round(100*p, 2), "%")

    titles<-c("Your dota2 win/lose graph is below")
    subtitles<-paste("winning rate is", roundp)

    ggplot(data=winlose, aes(x=winlose$status, y=winlose$number, fill= winlose$status)) +
      geom_bar(stat="identity")+
      labs(title = titles, subtitle = subtitles) +
      geom_text(aes(label=winlose$number), vjust=1.6, size=10) +
      guides(fill=FALSE)
}
