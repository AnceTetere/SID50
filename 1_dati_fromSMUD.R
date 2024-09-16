#Izmanto 4-tā ceturkšņa failu 
tab_name <- paste0("DS_struktura_DB", substr(year, 3, 4), "c4")
wb <- loadWorkbook(paste0("../SID50/", year, "/", year, "Q4/SMUD/", tab_name, ".xlsx"))
# wb <- loadWorkbook(paste0("../SID50/", year, "_(pārrēķināts 2024. gadā)/", year, "Q4/SMUD/", tab_name, ".xlsx"))
ws <- readWorksheet(wb, sheet = 1)
rm(wb, tab_name)

ws <- ws[ ,c("DAT", "VSN", "nT", "NOZ2", "G5")]
rownames(ws) <- NULL

#fSID50c <- read.csv("../SID50/2021_(pārrēķināts 2024. gadā)/yyyyQ4/final_SID50c.csv", sep=";")
Conf <- filter(fSID50c, TIME == paste0(year, "Q4"))

x <- Conf$N[Conf$S == "TOTAL" & Conf$I == "LC_OTH" & Conf$THSD_EUR_X == 10]
x <- x[!is.na(x)]
conf001 <- x

x <- Conf$N[Conf$S == "PU-S" & Conf$I == "LC_OTH" & Conf$THSD_EUR_X == 10]
x <- x[!is.na(x)]
conf023 <- x

x <- Conf$N[Conf$S == "PR-S" & Conf$I == "LC_OTH" & Conf$THSD_EUR_X == 10]
x <- x[!is.na(x)]
conf024 <- x
