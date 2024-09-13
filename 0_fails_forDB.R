#install.packages("tidyverse")
library(tidyverse)

base_path <- "../SID50/"
year <- readline(prompt = "Ievadīt gadu: ") 
path <- paste0(base_path, year, "/")
if(!dir.exists(path)) {dir.create(path)}

#No iepriekšējā gada faila izstrādā šablonu SID50
#setwd(paste0(base_path, as.numeric(year) - 1, "\\DB_fails"))
SID50 <- read.csv2("../SID50/DB_fails/SID50.csv")
SID50_ailes <- readRDS("../SID50/R_kods/SID50_ailes.rds")

#Sākuma šablons un saglabāt
  y <- SID50
  y <- y[, SID50_ailes]
  y$THSD_EUR[is.na(y$THSD_EUR)] <- ""
  y$THSD_EUR_X[is.na(y$THSD_EUR_X)] <- ""
  rownames(y) <- NULL

initial_SID50 <- y
rm(y)

#setwd(paste0(path, "intermediate_tables\\fails_forDB"))
#save(initial_SID50, file = "initial_SID50.RData")
#rm(initial_SID50)

#Gada šablons un saglabāt
nameDB <- paste0("additional_SID50_", year)
assign(nameDB, SID50[SID50$TIME == as.numeric(year) - 1, ])
  
  x <- get(nameDB)
  x$TIME <-paste0(year)
  rownames(x) <- NULL
  x$THSD_EUR <- ""
  
  x$S <- factor(x$S) # 3 levels
  x$I <- factor(x$I) # 16 levels
  assign(nameDB, x)

#---------------TEST
final_rows_SID50 <- nrow(SID50) + nrow(x)
#saveRDS(final_rows_SID50, file = "final_rows_SID50.RDS")
rm(x, SID50)

#setwd(paste0(path, "intermediate_tables/fails_forDB"))
#save(list = nameDB, file = paste0(nameDB, ".RData"))
#rm(list = nameDB)
#rm(nameDB)
