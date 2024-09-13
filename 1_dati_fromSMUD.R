# Dati no SMUD: Izmanto 4-tā ceturkšņa failu 

tab_name <- paste0("SID50", substr(year, 3, 4), "c4")
wb <- loadWorkbook(paste0("../SID50/", year, "/", year, "Q4/SMUD/", tab_name, ".xlsx"))
# wb <- loadWorkbook(paste0("../SID50/", year, "_(pārrēķināts 2024. gadā)/", year, "Q4/SMUD/", tab_name, ".xlsx"))
ws <- readWorksheet(wb, sheet = 1)
rm(wb)

ws <- ws[ ,c("DAT", "VSN", "nT", "NOZ2", "G5")]

