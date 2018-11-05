#' getmmr function returns a dataframe with your nickname and matchmaking rate score when passed dota2 id
#'
#' @param dota2ID your dota2 account ID
#'
#' @return NULL
#' @importfrom ROpenDota
#'
#' @export
#'
#' @examples
#' getmmr(135474549)
#'
#'
#'
getmmr<-function(dota2ID){
   e<-get_player_summaries(dota2ID)
   score<-as.data.frame(e$mmr_estimate$estimate)
   name<-as.data.frame(e$profile$personaname)
   mmr<-cbind(name,score)
   colnames(mmr)<-c("GameID","MMR score")
   return(mmr)
}
