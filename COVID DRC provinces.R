# Install and import R-packages 
# install.packages("rgdal")
# install.packages("RColorBrewer")
# install.packages("surveillance")

library("rgdal")#
library("RColorBrewer")#
library("surveillance")#

####Load shape file
#dowload manually from this website https://github.com/Joachimmarien/COVID19-DRC/blob/master/DRC_provinces_shapefile.zip
d2b <- readOGR("C:/Users/jmarien/Desktop/monkeypox viruses/congo zip file/Shapefiles_26PROV_ZS RDC/ProvinceRDC.shp") # change directory!!!
d2b=d2b[order(d2b$ADM1_NAME),]; 

#Simulate case data
# Cases=rnorm(length(d2b$ADM1_NAME),90000,1000)
# Cases[27]=0
# a=cbind(as.character(d2b$ADM1_NAME),Cases)
# write.csv(a,'DRC_COVID_simulation.csv')

#Load  data
# prov_cases <- read.csv("C:/Users/jmarien/Desktop/congo zip file/DRC_COVID_simulation2.csv", sep=";")# if using csv from own computer
prov_cases<-data.frame(read.csv(url("https://raw.githubusercontent.com/Joachimmarien/COVID19-DRC/master/DRC_COVID_simulation5.csv"))) # if using csv from github
Cases=c(round(prov_cases[,2]),0)

############################# Run script
d2b$Cases=Cases
my.palette <- brewer.pal(n = 8, name = "OrRd") # make color pallete for figure
date=Sys.Date()
prov=as.factor(d2b$ADM1_NAME)

# change legend depending on number of cases
if(max(Cases)<100000){at=seq(0,max(Cases),10000)}
if(max(Cases)<50000){at=seq(0,max(Cases),5000)} 
if(max(Cases)<10000){at=seq(0,max(Cases),1000)} 
if(max(Cases)<5000){at=seq(0,max(Cases),500)}
if(max(Cases)<1000){at=seq(0,max(Cases),100)}
if(max(Cases)<500){at=seq(0,max(Cases),50)}
if(max(Cases)<100){at=seq(0,max(Cases),10)}
if(max(Cases)<50){at=seq(0,max(Cases),5)}
if(max(Cases)<20){at=seq(0,max(Cases),2)}

li1 <- layout.labels(d2b, labels = list(font=0.03,cex=0.6, labels=prov))
li1$x[7,2]=-5.5
li1$x[8,2]=-6.5
par(mar=c(4,0,0,2))
z=spplot(d2b, "Cases", col.regions = my.palette, cuts = 7, col = "transparent",
         main = "DRC COVID19", sub = paste("Cases  ", date),
         colorkey = list(height = 1, labels = list(at = at,
              labels = at,height=0.2)), sp.layout = c(list(li1)))
z
# Make tiff file on computer with figure
# tiff(paste(date,"figure_DRC_COVID.tif"), res=500, compression = "lzw", height=7, width=7, units="in")
# z
# dev.off()

