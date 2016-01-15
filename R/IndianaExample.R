setwd("K:\\RSampleCode")
x<-c("stringr","XML","plyr","RCurl","ggplot2","maptools","rgeos","ggmap","dplyr","RJSONIO")
lapply(x, require, character.only=T)

load("zipCityCountyStateMap.Rda")
head(zipMap2)

cntyList=c("Marion County, IN","Hamilton County, IN","Boone County, IN","Hendricks County, IN","Johnson County, IN","Shelby County, IN","Hancock County, IN")
zipIndy=filter(zipMap2,ctyname %in% cntyList)
zipIndy2=zipIndy[!duplicated(zipIndy$ZCTA5),]

zipShp=readShapePoly("tl_2010_18_zcta500\\tl_2010_18_zcta500.shp")
zipShp2=fortify(zipShp,region="ZCTA5CE00")

zipShp=readShapePoly("tl_2010_18_zcta510/tl_2010_18_zcta510.shp")
zipShp2=fortify(zipShp,region="ZCTA5CE10")
