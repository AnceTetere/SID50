# Savieno t

#kP <- substr(kP, 3, 5)
savienotas_t <- character(0)

#t_SID50 <- c("113", "141", "183", "307", "316", "321", "322", "323", "324", "335", "337", "348", "349", "354", "358")
#setwd(paste0(path, "intermediate_tables\\interm_vectors"))
#saveRDS(t_SID50c, file = "t_SID50.rds")
#t_SID50 <- readRDS(paste0(path, "intermediate_tables\\interm_vectors\\t_SID50.rds"))
# ailes <- append(readRDS(paste0(path, "intermediate_tables\\interm_vectors\\SID50_ailes.rds")), "testa_aile")

t_SID50 <- readRDS(paste0(base_path, "R_kods/t_SID50.rds"))
rindas_N <- readRDS(paste0(base_path, "R_kods/rindas_N.rds"))

#1) Paņem 1. kP un pirmo sektoru

for(i in 1:kP) {

      switch(
    i,
    "s_001" = j <- "TOTAL",
    "s_023" = j <- "PU-S",
    "s_024" = j <- "PR-S"
  )
  
  #setwd(paste0(path, "intermediate_tables"))
  #load(paste0("template_", j, "_SID50_", year, ".RData"))
  #load(paste0("kP", kP[i], "_", year, ".RData"))
  
  x1 <- get(paste0("s_", kP[i]))
  rm(list = paste0("s_", kP[i]))
  
  x2 <- get(j)
  rm(list = j)
  
  split_kP <- split(x1, x1$nT)
  source(paste0(base_path, "R_kods\\fnc_rename_dataframes.R"))
  renamed_splitX1 <- rename_dataframes(split_kP, "T")
  list2env(renamed_splitX1, envir = .GlobalEnv)
  
  rm(x1, split_kP, renamed_splitX1, rename_dataframes)
  
  split_template <- split(x2, x2$I)
  list2env(split_template, envir = .GlobalEnv)
  
  rm(split_template, x2, T_212, T_216)

  for (k in 1:length(t_SID50)) {
  
    switch(
      t_SID50[k],
      "113" = ind <- "LC_WAG_DIR_TOTAL",
      "141" = ind <- "LC_WAG_DIR_SIC",
      "183" = ind <- "LC_WAG_TOT",
      "307" = ind <- "LC_SOC_DISSM",
      "316" = ind <- "LC_SUB",
      "321" = ind <- "LC_WAG_KIND",
      "322" = ind <- "LC_SOC_COMP",
      "323" = ind <- "LC_SOC_VOL",
      "324" = ind <- "LC_SOC_BEN",
      "335" = ind <- "LC_OTH",
      "337" = ind <- "LC_WAG_DIR_B",
      "348" = ind <- "LC_WAG_DIR_X_B",
      "349" = ind <- "LC_WAG_DIR_NW",
      "354" = ind <- "LC_TOTAL",
      "358" = ind <- "LC_SOC_TOT"
    )
    
    y <- get(paste0("T_", t_SID50[k]))
    sum(y$nT == t_SID50[k]) == nrow(get(paste0("T_", t_SID50[k])))
    
    y <- y[, c("NOZ2", "G5")]
    merged_DF <- merge(get(ind), y, by.x = "N", by.y = "NOZ2")
    
    merged_DF$THSD_EUR <- merged_DF$G5
    merged_DF <- merged_DF[,!colnames(merged_DF) == "G5"]
    
    rm(list = c(paste0("T_", t_SID50[k]), ind))
    rm(y)
    
    setwd(paste0(path, "intermediate_tables\\interm_vectors"))
    merged_DF <-
      merged_DF[match(rindas_N, merged_DF$N), ailes]
    
    rownames(merged_DF) <- NULL
    
    name_df <-
      paste0("k",
             kP[i],
             "T",
             t_SID50[k],
             "_",
             j,
             "_",
             ind)
    assign(name_df, merged_DF)
    rm(merged_DF)
    
    savienotas_t <-  append(savienotas_t, name_df)
    
    setwd(paste0(path, "intermediate_tables"))
    save(list = name_df, file = paste0(name_df, ".RData"))
    rm(list = c(name_df))
    rm(name_df)
  }  
}

rm(i, ailes, ind, j, k)


setwd(paste0(path, "\\intermediate_tables"))

for(g in 1:length(kP)) {
  switch(
  kP[g],
  "001" = l <- "TOTAL",
  "023" = l <- "PU-S",
  "024" = l <- "PR-S"
)
x1 <- get(load(paste0("k", kP[g], "T335_", l, "_LC_OTH.RData")))
rm(list = paste0("k", kP[g], "T335_", l, "_LC_OTH"))

x1$I <- "LC_OTH_TAX"
x1$testa_aile <- paste0(x1$testa_aile, "_TAX")

nameDF <- paste0("k", kP[g], "T335_", l, "_LC_OTH_TAX")
assign(nameDF, x1)

save(list = nameDF, file = paste0(nameDF, ".RData"))
savienotas_t <-  append(savienotas_t, nameDF)
rm(list = nameDF)
rm(x1, nameDF)
}

rm(LC_OTH_TAX, g, kP, l)

# Noglabā vektoru ar savienotajām tabulām
setwd(paste0(path, "intermediate_tables\\interm_vectors"))
saveRDS(savienotas_t, file = "savienotas_t.rds")
rm(savienotas_t, t_SID50)
