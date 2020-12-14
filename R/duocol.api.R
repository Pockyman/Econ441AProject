#' API Query
#' @description Duo column data
#'
#' @param URL URL
#' @param series_id Series id of API
#' @param APIkey API key
#' @param observation_start Observation start date with
#'
#' @return
#' @export
#'
#' @examples
#' duocol.api(URL, series_id, APIkey, observation_start)
#' duocol.api("http://api.eia.gov/series/","TOTAL.TETCBUS.M","4b7fc3dfb09c8ce47ef1323ea2eb5619","197301")
duocol.api <- function(URL, series_id, APIkey, observation_start){
  parameter = paste(
    "?series_id=", series_id,
    "&api_key=", APIkey,
    "&start=", observation_start,
    "&file_type=json",
    sep = "")

  PATH = paste0(URL, parameter)
  initalq <- fromJSON(PATH)
  df_pw<-as.data.frame(initalq$series$data)
  df_pw$X1 <- rev(df_pw[,1])
  df_pw$X2 <- rev(df_pw[,2])
  df_pw$X1 <- as.character(df_pw$X1)
  df_pw$X2 <- as.character(df_pw$X2)
  colnames(df_pw)[1] <- "x1"
  colnames(df_pw)[2] <- "x2"
  return(df_pw)
}
