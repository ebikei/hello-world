setwd("F:\\Dropbox\\R Sample Code\\Data")
x<-c("stringr","XML","plyr","RCurl","ggplot2","maptools","rgeos","ggmap","dplyr","RJSONIO")
lapply(x, require, character.only=T)

load("zipCityCountyStateMap.Rda")
head(zipMap2)

cntyList=c("Marion County, IN","Hamilton County, IN","Boone County, IN","Hendricks County, IN","Johnson County, IN","Shelby County, IN","Hancock County, IN")
zipIndy=filter(zipMap2,ctyname %in% cntyList)
zipIndy2=zipIndy[!duplicated(zipIndy$ZCTA5),]

zipShp=readShapePoly("tl_2010_18_zcta510/tl_2010_18_zcta510.shp")
zipShp2=fortify(zipShp,region="ZCTA5CE10")

# retain zips in Indy area
zipShp3=zipShp2[zipShp2$id %in% zipIndy$ZCTA5,]

x=get_googlemap(center="indianapolis",maptype=c("roadmap"))
p=ggmap(x)
p=p+geom_polygon(data=zipShp3,aes(x=long,y=lat,group=id),fill="blue",color="black",alpha=0.2)
print(p)
