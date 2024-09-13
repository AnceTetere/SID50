#1) Paņem SMUD datus
s <- ws
rm(ws)

#3) Sadala SMUD datni pa kp
levels(s$VSN)

s_split <- split(s, s$VSN)
renamed_s_split <- rename_dataframes(s_split, "s")
list2env(renamed_s_split, envir = environment())

rm(s_split, s, renamed_s_split, rename_dataframes)

# uzreiz saglabā
#setwd(paste0(path, "intermediate_tables"))
kP <- c("s_001", "s_023", "s_024")

#for (i in 1:length(kP)) {
#  nameDF <-
#    paste0("kP", substr(kP[i], 3, nchar(kP[i])), "_", year)
#  assign(nameDF, get(kP[i]))
#  save(list = kP[i], file = paste0(nameDF, ".RData"))
#  rm(list = c(kP[i], nameDF))
#}

#setwd(paste0(path, "intermediate_tables\\interm_vectors"))
#saveRDS(kP, file = "kP.rds")
#saveRDS(SID50_ailes, file = "SID50_ailes.rds")
#saveRDS(a_testa_rinda, file = "SID50_testa_rinda.rds")

rm(i, kP, nameDF, SID50_ailes, a_testa_rinda)
