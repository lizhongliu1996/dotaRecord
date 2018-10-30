#' This function tells your top-rank heroes when passed dota2 id
#'
#' @param dota2ID your dota2 account ID
#'
#' @return NULL
#' @import ggplot2 ROpenDota
#'
#' @export
#'
#' @examples
#' hero_rank(135474549)
#'
#'
#'
hero_rank<-function(dota2ID){
  rank<-get_hero_rankings(dota2ID)[1:10,]
  hero<-get_heroes()
  id<-rank$hero_id
  q<-hero[,1] %in% id
  hero_name<-as.data.frame(hero[q,1:3])
  colnames(hero_name)<-c("hero_id","longname","hero_name")
  herosrank<-merge(rank,hero_name,by="hero_id")
  newdata<-herosrank[order(-herosrank$percent_rank),]
  newdata$percent_rank<-paste(round(100*newdata$percent_rank, 2), "%")

  titles<-c("The graph is below your top 10 ranked heroes")

  ggplot(data=newdata,aes(y=newdata$percent_rank, x=newdata$hero_name, fill=newdata$hero_name)) +
    geom_bar(stat="identity")+
    labs(title = titles) +
    geom_text(aes(label=newdata$percent_rank), vjust=1.2, size=4)

}

