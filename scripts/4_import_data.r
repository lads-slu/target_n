#raster
ndre75<-rast(ndre75.tif)
ndre75<-ndre75/255

if(strategy=='useryieldmap'){
  yield<-rast(yield.tif)
  params<-read.delim(params.txt) 
  #rescale yield raster to kg pr ha
  a<-params$a
  b<-params$b
  yield<-a+(b-a)*(yield-1)/(255-1) 
  #rescale yield by user specified ymax
  yield<-yield*as.numeric(ymax)/as.numeric(global(yield, "mean", na.rm = TRUE))
  }

##polygons
aoi<-vect(aoi.shape)

#define projections
prj<-"epsg:3006"
crs(ndre75)<-prj
if(strategy=='useryieldmap')crs(yield)<-prj
crs(aoi)<-prj

#plot results
plt(y=aoi, x=ndre75, main='ndre75 -imported', plot.results=plot.results)
if(strategy=='useryieldmap')plt(y=aoi, x=yield, main='yield -imported', plot.results=plot.results)

#give feedback
print('Data have been imported')