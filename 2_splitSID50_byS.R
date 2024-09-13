# Paņem gada šablonu additional_SID50_yyyy un aizpildi to

#1) Paņem gada šablonu additional_SID50_yyyy
a <- get(nameDB) 
rm(list = nameDB)

# izņem NAs
a$THSD_EUR_X[is.na(a$THSD_EUR_X)] <- ""
a$THSD_EUR_X <- ""

#2) Pirmais grieziens ir S SID50 gada šablonā
levels(a$S)

a_split <- split(a, a$S)
split_SS <- names(a_split)
list2env(a_split, envir = environment())
rm(a_split, a)

#uzreiz noglabā
#setwd(paste0(path, "intermediate_tables"))
#Nesaprotu, priekš kam šis
#for(i in 1:length(split_SS)) {
#  split_SS[i]
#  nameDF <- paste0(split_SS[i], "_SID50_", year)
#  assign(nameDF, get(split_SS[i]))
  #save(list = split_SS[i], file = paste0("template_", nameDF, ".RData"))
  #rm(list = c(split_SS[i], nameDF))
#}

#saveRDS(split_SS, file = "split_SS.rds")
#rm(i, nameDF, split_SS)
