#' radiant plot Helper function that draws a bar chart when passed dota2 id
#' shows your winning rate in team radiant
#' @param dota2ID your dota2 account ID
#'
#' @return NULL
#' @import ggplot2 ROpenDota
#'
#' @export
#'
#' @examples
#' radiant_plot(135474549)
#'
#'
#'
radiant_plot<-function(dota2ID){
  ###win in radiant
  winIndifside<-count_in_categories(dota2ID)
  radiant<-winIndifside$is_radiant$`1`
  rad_win <- data.frame(status=c("win", "total"),
                        number=c(radiant$win,radiant$games))
  rad_p<-rad_win[1,2]/rad_win[2,2]
  round_rad_p<-paste(round(100*rad_p, 2), "%")
  rad_winlose<-as.data.frame(matrix(ncol=2,nrow=2))
  rad_winlose[,1]<-c("win","lose")
  rad_winlose[1,2]<-rad_win[1,2]
  rad_winlose[2,2]<-(rad_win[2,2]-rad_win[1,2])
  names(rad_winlose)<-c("status","number")

  rad_titles<-c("Team radiant win/lose graph is below")
  rad_subtitles<-paste("your win rate in radiant is", round_rad_p)
  rad_status<-as.data.frame(rad_winlose$status)
  rad_number<-as.data.frame(rad_winlose$number)

  ggplot(data=rad_winlose,aes(x=rad_winlose$status, y=rad_winlose$number, fill=rad_winlose$status)) +
    geom_bar(stat="identity") +
    labs(title = rad_titles, subtitle = rad_subtitles, x="Number",y="Status") +
    geom_text(aes(label=rad_winlose$number), vjust=1.6, size=10) +
    guides(fill=FALSE)
}
