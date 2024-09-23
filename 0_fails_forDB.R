#install.packages("tidyverse")
#install.packages("XLConnect")
library(tidyverse)
library(XLConnect)

base_path <- "DB/SID50c/"
year <- readline(prompt = "Ievadīt gadu: ") 
path <- paste0(base_path, year, "/")
if(!dir.exists(path)) {dir.create(path)}

source(paste0(base_path, "R_kods/fnc_rename_dataframes.R"))

#No iepriekšējā gada faila izstrādā šablonu SID50c
#setwd(paste0(base_path, as.numeric(year) - 1, "\\DB_fails"))
SID50c <- read.csv2("DB/SID50c/DB_fails/SID50c.csv")
SID50c_ailes <- readRDS("../SID50c/R_kods/SID50c_ailes.rds")

#Sākuma šablons un saglabāt
  y <- SID50c
  y <- y[, SID50c_ailes]
  y$THSD_EUR[is.na(y$THSD_EUR)] <- ""
  y$THSD_EUR_X[is.na(y$THSD_EUR_X)] <- ""
  rownames(y) <- NULL

  initial_SID50c <- y
  rm(y)

#Gada šablons
nameDB <- paste0("additional_SID50c_", year)
assign(nameDB, SID50c[SID50c$TIME == as.numeric(year) - 1, ])

  x <- get(nameDB)
  x$TIME <- year
  rownames(x) <- NULL
  x$THSD_EUR <- ""
  x$THSD_EUR_X <- ""
  
  x$S <- factor(x$S) # 3 levels
  x$I <- factor(x$I) # 16 levels
  assign(nameDB, x)

#---------------TEST
x <- x[!(is.na(x$I) & is.na(x$S) & is.na(x$N)), ]
final_rows_SID50c <- nrow(initial_SID50c) + nrow(x)
rm(x, SID50c)
