poblacion <- 19678363

##### 1. País #####
chile <- datos

##### 1.1 2021
chile_2021 <- chile[chile$X1 == 2021,]
chile_2021 <- rename(chile_2021,
                         sistema_u_otro = X11,
                         grupo = X13,
                         categoria = X15,
                         subcategoria = X17)

##### 1.2 Por sistema ####
resumen_sistema <- 
  chile_2021 %>% 
  group_by(sistema_u_otro) %>% 
  summarise(
    total = n(),
    tasa_mortalidad = ((n() * 100000) / poblacion),
    .groups = 'drop'
  )


sum(resumen_sistema$tasa_mortalidad)

##### 1.3 Desglose sistema y grupo ####
sistema_grupo <- 
  chile_2021 %>%
  group_by(sistema_u_otro, grupo)  %>%
  summarise(
    total = n(),
    tasa_mortalidad = ((n() * 100000) / poblacion),
    .groups = 'drop'
  )

sistema_grupo_categoria <- 
  chile_2021 %>%
  group_by(sistema_u_otro, grupo, categoria)  %>%
  summarise(
    total = n(),
    tasa_mortalidad = ((n() * 100000) / poblacion),
    .groups = 'drop'
  )

sistema_grupo_categoria_subcategoria <- 
  chile_2021 %>%
  group_by(sistema_u_otro, grupo, categoria, subcategoria)  %>%
  summarise(
    total = n(),
    tasa_mortalidad = ((n() * 100000) / poblacion),
    .groups = 'drop'
  )

# summary <- sistema_grupo_categoria_subcategoria
# summary <- summary[summary$X11 == 'Enfermedades del sistema circulatorio',]
# sum(summary$total)

# isquemicas <- datos[datos$X7 == 'Lautaro' & datos$X1 == 2021 & datos$X12 == 'I20-I25',]

##### wrt ####
write.csv(chile, "c-chile/datos.csv", row.names=TRUE)
write.csv(chile_2021, "c-chile/2021/datos.csv", row.names=FALSE)
write.csv(resumen_sistema, "c-chile/2021/por_sistema.csv", row.names=FALSE)
write.csv(sistema_grupo, "c-chile/2021/por_grupo.csv", row.names=FALSE)
write.csv(sistema_grupo_categoria, "c-chile/2021/por_sistema_grupo_categoria.csv", row.names=FALSE)
write.csv(sistema_grupo_categoria_subcategoria, "c-chile/2021/por_sistema_grupo_categoria_subcategoria.csv", row.names=FALSE)

