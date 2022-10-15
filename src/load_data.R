load_data <- function() {
  data <- readr::read_delim("rawdata/DEFUNCIONES_FUENTE_DEIS_2016_2022_06102022.csv", 
                    delim = ";", escape_double = FALSE, col_names = FALSE, 
                    locale = readr::locale(encoding = "ISO-8859-1"), 
                    trim_ws = TRUE)
  return(rename(data, sistema_u_otro = X11, grupo = X13, categoria = X15, 
                subcategoria = X17))
}
