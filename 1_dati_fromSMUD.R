#Izmanto 4-tā ceturkšņa failu 
tab_name <- paste0("DS_struktura_DB", substr(year, 3, 4), "c4")
wb <- loadWorkbook(paste0("../SID50/", year, "/", year, "Q4/SMUD/", tab_name, ".xlsx"))
ws <- readWorksheet(wb, sheet = 1)
rm(wb, tab_name)

ws <- ws[ ,c("DAT", "VSN", "nT", "NOZ2", "G5")]

t216 <- ws[ws$nT == "216", ]
colnames(t216)[colnames(t216) == "G5"] <- "t216"

rownames(ws) <- NULL
rownames(t216) <- NULL
