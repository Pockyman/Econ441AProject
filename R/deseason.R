#' Decompose the seasonal factor from timeseries
#'
#' @param timeseries The timeseries data you would like to apply
#' @param type Type of seasonal factor. (additive or multiplicative)
#'
#' @return
#' @export
#'
#' @examples
#' deseason(timeseries, type="additive")
deseason <- function(timeseries, type="additive"){

  df.ts.a <- decompose(timeseries, "additive")
  df.ts.a.adj <- timeseries - df.ts.a$seasonal

  df.ts.m <- decompose(timeseries, "multiplicative")
  df.ts.m.adj <- timeseries/df.ts.m$seasonal

  ifelse(type=="multiplicative", return(df.ts.m.adj),
         ifelse(type=="additive", return(df.ts.a.adj), "Invalid type"))

}
