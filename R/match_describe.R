#' Helper function that shows information about a specficial when passed match id
#'
#' @param matchID a dota2 match ID
#'
#' @return NULL
#' @import ggplot2 ROpenDota tidyverse
#'
#' @export
#'
#' @examples
#' match_results(4172245371)
#'
#'
#'
match_results<-function(matchID){
  a<-get_match_details(matchID)


  ###get what heros inside this game
  heroInfo<-as.data.frame(a$players$hero_id)
  names(heroInfo)<-c("hero_id")
  hero<-get_heroes()
  q<-hero[,1] %in% heroInfo$hero_id
  hero_name<-hero[q,1:3]
  colnames(hero_name)<-c("hero_id","full name","hero name")
  heroInfo<-left_join(heroInfo,hero_name,by="hero_id")
  heroInfo <- hero_name["hero name"]

  heroInfo$player_name<-a$players$personaname
  heroInfo$account_id<-a$players$account_id
  heroInfo$team<-matrix(c(rep("Radiant",5),rep("Dire",5)))
  heroInfo$levels<-a$players$level
  heroInfo$kills<-a$players$kills
  heroInfo$deaths<-a$players$deaths
  heroInfo$assists<-a$players$assists
  heroInfo$kda<-a$players$kda
  heroInfo$last_hits<-a$players$last_hits
  heroInfo$denies<-a$players$denies
  heroInfo$gold_per_min<-a$players$gold_per_min
  heroInfo$xp_per_min<-a$players$xp_per_min
  heroInfo$hero_damage<-a$players$hero_damage
  heroInfo$tower_damage<-a$players$tower_damage



}
