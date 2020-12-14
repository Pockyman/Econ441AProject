#' Total Primary Energy Consumption in Monthly frequency
#'
#' @format 572 x 2 dataframe
#'
#' @description This dataset is from U.S. Energy Information Administration. It is the Total Primary Energy Consumption in Monthly frequency from Jan 1973 to August 2020. The unit is in Billion Btu. According to EIA, the definition of Total primary energy consumption is: "The sum of the consumption values for fossil fuels, nuclear electric power, and renewable energy, plus electricity net imports." Data reveals the pattern of our energy consumption and trend over time.
#'
#' \describe{
#' \item{date}{year and month of the data}
#' \item{TOTAL.TETCBUS.M}{Total Primary Energy Consumption in Monthly frequency in Billion Btu}
#'}
#'
"EIAdata"
EIAdata <- read.csv("EIAdata")
usethis::use_data(EIAdata, overwrite=TRUE)
