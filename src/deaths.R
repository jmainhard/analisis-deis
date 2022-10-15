deaths <- function(commune = NULL, region = NULL, year = NULL) {
  if (!is.null(commune) & is.null(region)) {
    by_commune <- data[data$X7 == commune,] 
    if (is.null(year)) {
      return(by_commune)
    } else {
      return(deaths_by_year(by_commune, year))
    }
  } else if (is.null(commune) & !is.null(region)) {
    return(data[data$X8 == region,])
  } else if (is.null(commune) & is.null(region)) {
    logger::log_error("deaths(): se requiere almenos uno de los parámetros")
  } else {
    logger::log_error("deaths(): no es posible calcular por región y comuna")
  }
}

deaths_by_year <- function(data, year) {
   return(data[data$X1 == year,])
}
