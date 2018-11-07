#' Helper function that shows information about a specficial match when passed match id
#'
#' @param matchID a dota2 match ID
#'
#' @return NULL
#' @import ROpenDota
#'
#' @export
#'
#' @examples
#' match_wins(4172245371)
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
