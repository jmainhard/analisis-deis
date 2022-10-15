lautaro <- function() {
  basepath <-  "producto/a-lautaro/"
  poblacion <- 41065
  deaths <- deaths('Lautaro')
  export_by_place(deaths, basepath)
  
  years <- c(2016, 2017, 2018, 2019, 2020, 2021)
  for (year in years) {
    defunciones_by_year <- deaths_by_year(deaths, year)
    data_list <- get_data_list(defunciones_by_year)
    year_path <- paste(basepath, year, "/", sep = "") 
    export(data_list, year_path)
  }
}

get_data_list <- function(data) {
  return(list(data,
              por_sistema(data),
              por_grupo(data),
              por_categoria(data),
              por_subcategoria(data))
         )
}

export <- function(data_list, path) {
  data_export <- c("datos.csv",
                   "resumen_sistema.csv",
                   "resumen_grupo.csv",
                   "resumen_categoria.csv",
                   "resumen_subcategoria.csv")

  # Escribir
  range <- 1:length(data_list)
  for (i in range) {
    full_path <- paste(path, "0", i, "-", data_export[i], sep = "")
    write.csv(data_list[[i]], full_path)
    logger::log_info("export(): Guardado: ", full_path)
  }
}

export_by_place <- function(data, path) {
  full_path <- paste(path, "datos.csv", sep = "")
  write.csv(data, full_path)
  logger::log_info("export_by_place(): Guardado: ", full_path)
}

# TODO: modularizar y considerar cambios de población por año
##### 1.3 Tasa de mortalidad causa, grupo, categoría y subcategoría ####
# Causa defunción (GLOSA_CAPITULO_DIAG1)
# TODO: se podría hacer todo en un sólo data frame o tabla
por_sistema <- function(data) { 
  data %>% 
  group_by(sistema_u_otro)  %>%
  summarise(
    total = n(),
    tasa_mortalidad = ((n() * 100000) / poblacion),
    .groups = 'drop'
  )
}

# Grupo causa defunción (GLOSA_GRUPO_DIAG1)
por_grupo <- function(data) { 
  data %>%
  group_by(sistema_u_otro, grupo)  %>%
  summarise(
    total = n(),
    tasa_mortalidad = ((n() * 100000) / poblacion),
    .groups = 'drop'
  )
}

# Categoría causa defunción (GLOSA_CATEGORIA_DIAG1)
por_categoria <- function(data) {
  data %>%
  group_by(sistema_u_otro, grupo, categoria)  %>%
  summarise(
    total = n(),
    tasa_mortalidad = ((n() * 100000) / poblacion),
    .groups = 'drop'
  )
}

# Subcategoría causa defunción (GLOSA_SUBCATEGORIA_DIAG1)
por_subcategoria <- function(data) {
  data %>%
  group_by(sistema_u_otro, grupo, categoria, subcategoria)  %>%
  summarise(
    total = n(),
    tasa_mortalidad = ((n() * 100000) / poblacion),
    .groups = 'drop'
  )
}