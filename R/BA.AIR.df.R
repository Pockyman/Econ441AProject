#' Get the latest update for BA~AIRBUS cointegration trading strategy
#'
#' @param fromdate Start date of observation
#'
#' @return
#' @export
#'
#' @examples
#' BA.AIR.df(fromdate)
BA.AIR.df <- function(fromdate="2015-01-01"){

  quantmod::getSymbols("BA",from=fromdate)
  quantmod::getSymbols("EADSY",from=fromdate)

  BA_close <- unclass(BA$BA.Close)
  EADSY_close <- unclass(EADSY$EADSY.Close)

  BA <- unclass(BA$BA.Adjusted)
  EADSY <- unclass(EADSY$EADSY.Adjusted)

  BA = as.data.frame(BA)
  EADSY = as.data.frame(EADSY)
  rolling = na.omit(cbind.data.frame(BA$BA.Adjusted, EADSY$EADSY.Adjusted))

  # Parameters
  T = 130                    # Backward Looking window in Days
  Z_score = 1.645              # Amount of standard deviationa to creat bounds
  percent_cointegration = .05 # Percent we reject on the t-test
  EMA = .1/T                  # Smaller value creates a less reactyive mean
  obs = nrow(rolling)         # Number of observations

  # Initialize empty columns of a dataframe
  rolling$hedge_ratio = NA
  rolling$Spread = NA
  rolling$mean = 1
  rolling$sd = NA
  #rolling$Cointegrated = NA  #initialize this line and line 94 to see the rolling ADF test

  # t is todays observation
  for (t in T:obs){

    reg = lm(rolling["BA$BA.Adjusted"][(t-T):t,1]~rolling["EADSY$EADSY.Adjusted"][(t-T):t,1])
    rolling$hedge_ratio[t] = reg$coefficients[2]
    rolling$Spread[t] = rolling["BA$BA.Adjusted"][t,1] - rolling$hedge_ratio[t] * rolling["EADSY$EADSY.Adjusted"][t,1]

    rolling$mean[t] = EMA * (rolling$Spread[t]) + ((1-EMA) *rolling$mean[(t-1)])
    rolling$sd[t] = sd(rolling$Spread[(t-T):t])
    #rolling$Cointegrated[t] = pass_DF_test(reg$residuals, percent_cointegration)

  }

  rolling = na.omit(rolling)
  rolling$lower_bound = rolling$mean - ( Z_score *  rolling$sd )
  rolling$higher_bound = rolling$mean + ( Z_score *  rolling$sd )

  t <- 1:length(rolling$Spread)

  plot <- ggplot(data=rolling, aes(x=t)) +
    geom_line(aes(y=rolling$Spread),color="black") +
    geom_line(aes(y=rolling$lower_bound),color="green",linetype="twodash") +
    geom_line(aes(y=rolling$higher_bound),color="green",linetype="twodash") +
    geom_line(aes(y=rolling$mean),color="red")

  return(rolling)
}
