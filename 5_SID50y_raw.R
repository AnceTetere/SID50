#1) Sašuj t kopā lielajai SID50 gada tabulai
sTab <- savienotas_t
building_SID50 <- data.frame()
rm(savienotas_t)

for (i in sTab) {
  building_SID50 <- rbind(building_SID50, get(i))
  rm(list = i)  
}
rm(i, sTab)

#2) Pārsauc
DF_name <- paste0("SID50_", year)
assign(DF_name, building_SID50)
rm(building_SID50)
