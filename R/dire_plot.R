#' dire plot Helper function that draws a bar chart to show
#' your winning rate in team dire when passed dota2 id
#'
#' @param dota2ID your dota2 account ID
#'
#' @return NULL
#' @import ggplot2 ROpenDota
#'
#' @export
#'
#' @examples
#' dire_plot(135474549)
#'
#'
#'
dire_plot<-function(dota2ID){
  ###win in dire
  winIndifside<-count_in_categories(dota2ID)
  dire<-winIndifside$is_radiant$`0`
  dire_win <- data.frame(status=c("win", "total"),
                         number=c(dire$win,dire$games))
  dire_p<-dire_win[1,2]/dire_win[2,2]
  round_dire_p<-paste(round(100*dire_p, 2), "%")
  dire_winlose<-as.data.frame(matrix(ncol=2,nrow=2))
  dire_winlose[,1]<-c("win","lose")
  dire_winlose[1,2]<-dire_win[1,2]
  dire_winlose[2,2]<-(dire_win[2,2]-dire_win[1,2])
  names(dire_winlose)<-c("status","number")

  dire_titles<-c("Team dire win/lose graph is below")
  dire_subtitles<-paste("your win rate in dire is", round_dire_p)
  dire_status<-as.data.frame(dire_winlose$status)
  dire_number<-as.data.frame(dire_winlose$number)

  ggplot(data=dire_winlose,aes(x=dire_winlose$status, y=dire_winlose$number, fill=dire_winlose$status)) +
    geom_bar(stat="identity")+
    labs(title = dire_titles, subtitle = dire_subtitles, x="Number",y="Status") +
    geom_text(aes(label=dire_winlose$number), vjust=1.6, size=10) +
    guides(fill=FALSE) +
    theme(
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      panel.background = element_rect(fill = "transparent",colour = NA),
      plot.background = element_rect(fill = "transparent",colour = NA)
    )

}
