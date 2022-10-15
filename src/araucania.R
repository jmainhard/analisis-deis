poblacion <- 1019548

##### 1. Región de la araucanía #####
araucania <- deaths(region = "De La Araucanía")

##### 1.1 2021
araucania_2021 <- deaths_by_year(araucania, 2021)

##### 1.2 Por sistema ####
resumen_sistema <- 
  araucania_2021 %>% 
  group_by(sistema_u_otro) %>% 
  summarise(
    total = n(),
    tasa_mortalidad = ((n() * 100000) / poblacion),
    .groups = 'drop'
  )
  
##### 1.3 Desglose sistema y grupo ####
sistema_grupo <- 
  araucania_2021 %>%
  group_by(sistema_u_otro, grupo)  %>%
  summarise(
    total = n(),
    tasa_mortalidad = ((n() * 100000) / poblacion),
    .groups = 'drop'
  )

sistema_grupo_categoria <- 
  araucania_2021 %>%
  group_by(sistema_u_otro, grupo, categoria)  %>%
  summarise(
    total = n(),
    tasa_mortalidad = ((n() * 100000) / poblacion),
    .groups = 'drop'
  )

sistema_grupo_categoria_subcategoria <- 
  araucania_2021 %>%
  group_by(sistema_u_otro, grupo, categoria, subcategoria)  %>%
  summarise(
    total = n(),
    tasa_mortalidad = ((n() * 100000) / poblacion),
    .groups = 'drop'
  )

##### wrt ####
write.csv(araucania, "araucanía/datos.csv", row.names=TRUE)
write.csv(araucania_2021, "araucanía/2021/datos.csv", row.names=FALSE)
write.csv(resumen_sistema, "araucanía/2021/por_sistema.csv", row.names=FALSE)
write.csv(sistema_grupo, "araucanía/2021/por_grupo.csv", row.names=FALSE)
write.csv(sistema_grupo_categoria, "araucanía/2021/por_sistema_grupo_categoria.csv", row.names=FALSE)
write.csv(sistema_grupo_categoria_subcategoria, "araucanía/2021/por_sistema_grupo_categoria_subcategoria.csv", row.names=FALSE)

