setwd("K:\\RSampleCode")
x<-c("stringr","zipcode","dplyr")
lapply(x, require, character.only=T)
# get state and county id-name maps
# http://www.census.gov/econ/cbp/download/georef02.txt
stateCntyCodes = read.table("georef02.txt", sep = ",", colClasses = c("character"),header = TRUE)
zipCnty=read.table("zcta_county_rel_10.txt", sep = ",", colClasses = c("character"),header = TRUE)
head(zipCnty)
data(zipcode)
head(zipcode)

# merge zip-city with zip-county-state
zipMap = merge(zipCnty[, c("ZCTA5", "STATE", "COUNTY")], zipcode[, c("zip","city")], by.x = "ZCTA5", by.y = "zip")
# get names of county and state
zipMap2 = merge(zipMap, stateCntyCodes, by.x = c("STATE", "COUNTY"), by.y = c("fipstate","fipscty"))
zipMap2$stname = sapply(zipMap2$ctyname, function(x) str_split(x, ",")[[1]][2])
head(zipMap2)
save(zipMap2,file="zipCityCountyStateMap.Rda")



