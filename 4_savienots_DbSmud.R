# Savieno t
savienotas_t <- character(0)

t_SID50 <- readRDS(paste0(base_path, "R_kods/t_SID50.rds"))
rindas_N <- readRDS(paste0(base_path, "R_kods/rindas_N.rds"))

#1) Paņem 1. kP 
for(i in kP) {

      switch(
    i,
    "s_001" = j <- "TOTAL",
    "s_023" = j <- "PU-S",
    "s_024" = j <- "PR-S"
  )
  
  x1 <- get(i)
  x2 <- get(j)
  rm(list = c(i, j))
  
  split_kP <- split(x1, x1$nT)
  renamed_splitX1 <- rename_dataframes(split_kP, "T") 
  list2env(renamed_splitX1, envir = environment())
  
  rm(x1, split_kP, renamed_splitX1)
  
  split_template <- split(x2, x2$I)
  list2env(split_template, envir = environment())
  
  rm(split_template, x2, T_212, T_216)

  for (k in t_SID50) {
  
    switch(
      k,
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
    
    y <- get(paste0("T_", k))
    
    if (sum(y$nT == k) == nrow(get(paste0("T_", k)))) {
      y <- y[, c("NOZ2", "G5")]
      merged_DF <- merge(get(ind), y, by.x = "N", by.y = "NOZ2")
      
      merged_DF$THSD_EUR <- merged_DF$G5
      merged_DF$G5 <- NULL
      
      rm(list = c(paste0("T_", k), ind), y)
    } else {
      stop("4_savienots_DBarSMUD: Tabulu nesakritība! \n")
    }
    
    merged_DF <- merged_DF[match(rindas_N, merged_DF$N), SID50_ailes]
    rownames(merged_DF) <- NULL
    
    name_df <- paste0("k", substr(i, 3, 5), "T", k)
    assign(name_df, merged_DF)
    rm(merged_DF)
    
    savienotas_t <-  append(savienotas_t, name_df)

  }  
}

rm(i, ind, j, k, name_df)


for(g in kP) {
  switch(
  g,
  "s_001" = l <- "TOTAL",
  "s_023" = l <- "PU-S",
  "s_024" = l <- "PR-S"
)
x1 <- get(paste0("k", substr(g, 3, 5), "T335"))
#rm(list = paste0("k", kP[g], "T335_", l, "_LC_OTH"))

x1$I <- "LC_OTH_TAX"
nameDF <- paste0("k", substr(g, 3, 5), "T335_TAX")
assign(nameDF, x1)

savienotas_t <-  append(savienotas_t, nameDF)
rm(x1, nameDF)
}

rm(LC_OTH_TAX, g, l, t_SID50)
