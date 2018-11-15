#' get_mmr function returns a dataframe with your nickname
#'  and matchmaking rate score when passed dota2 id
#'
#' @param dota2ID your dota2 account ID
#'
#' @return NULL
#' @import ROpenDota
#'
#' @export
#'
#' @examples
#' get_mmr(135474549)
#'
#'
#'
get_mmr<-function(dota2ID){
   e<-get_player_summaries(dota2ID)
   score<-as.data.frame(e$mmr_estimate$estimate)
   name<-as.data.frame(e$profile$personaname)
   mmr<-cbind(name,score)
   colnames(mmr)<-c("GameID","MMR_score")
   return(mmr)
}
