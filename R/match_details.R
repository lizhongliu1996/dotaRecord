#' This function returns a data frame shows player information
#'  about a specifical match when passed a match id
#'
#' @param matchID a dota2 match ID
#'
#' @return NULL
#' @import ROpenDota
#'
#' @export
#'
#' @examples
#' match_details(4172245371)
#'
#'
#'
match_details<-function(matchID){
  a<-get_match_details(matchID)
  heroInfo<-as.data.frame(a$players$hero_id)
  names(heroInfo)<-c("hero_id")
  hero<-get_heroes()
  q<-hero[,1] %in% heroInfo$hero_id
  hero_name<-hero[q,1:3]
  hero_name<-hero_name[order(match(hero_name$id,heroInfo$hero_id)),]
  colnames(hero_name)<-c("hero_id","full name","hero name")

  heroInfo <- hero_name["hero name"]

  heroInfo$player_name<-a$players$personaname
  heroInfo$account_id<-a$players$account_id
  heroInfo$team<-matrix(c(rep("Radiant",5),rep("Dire",5)))
  heroInfo$status<-a$players$win
  heroInfo$status<-ifelse(heroInfo$status==1,"win","lose")
  heroInfo$levels<-a$players$level
  heroInfo$kills<-a$players$kills
  heroInfo$deaths<-a$players$deaths
  heroInfo$assists<-a$players$assists
  heroInfo$kda<-a$players$kda
  heroInfo$last_hits<-a$players$last_hits
  heroInfo$denies<-a$players$denies
  heroInfo$gold_per_min<-a$players$gold_per_min
  heroInfo$total_gold<-a$players$total_gold
  heroInfo$xp_per_min<-a$players$xp_per_min
  heroInfo$total_xp<-a$players$total_xp
  heroInfo$hero_damage<-a$players$hero_damage
  heroInfo$tower_damage<-a$players$tower_damage
  heroInfo$hero_heal<-a$players$hero_healing

  return(heroInfo)
}
