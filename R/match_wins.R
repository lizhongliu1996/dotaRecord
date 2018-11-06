#' Helper function that shows information about a specficial when passed match id
#'
#' @param matchID a dota2 match ID
#'
#' @return NULL
#' @import ggplot2 ROpenDota
#'
#' @export
#'
#' @examples
#' match_describe(4172245371)
#'
#'
match_wins<-function(matchID){
  a<-get_match_details(matchID)
  ##which side wins
  if(a$radiant_win==TRUE){
    print("Team radiant win this game!")
  }else{
    print("Team dire win this game!")
  }
}
