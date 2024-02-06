#additional setting
mean.filter<-TRUE

#mask index raster by 15 m
aoi_small<-buffer(aoi, -15)
aoi_big<-buffer(aoi, 25)
ndre75<-crop(ndre75, aoi); ndre75<-mask(ndre75, aoi_small)
ndre75<-extend(x=ndre75, y=aoi_big, fill=NA)
plt(y=aoi, x=ndre75, main='ndre75 -cropped', plot.results=plot.results)

if(strategy=='useryieldmap'){
#resample crop and mask yield to ndre75 raster
  yield<-resample(yield, ndre75)
  yield<-crop(yield, aoi); yield<-mask(yield, aoi_small)
  yield<-extend(x=yield, y=aoi_big, fill=NA)
  yield<-crop(yield, ndre75); yield<-mask(yield, ndre75)
plt(y=aoi, x=yield, main='yield -cropped', plot.results=plot.results)
}

if(mean.filter) {
  w<-matrix(data=1,nrow=3, ncol=3)
  ndre75<-focal(ndre75, w=w, na.rm=T, pad=T, fun=mean)
  ndre75<-crop(ndre75, aoi_big); ndre75<-mask(ndre75, aoi_big)
  plt(y=aoi, x=ndre75, main='ndre75 -mean filtered', plot.results=plot.results)
  if(strategy=='useryieldmap'){
    yield<-focal(yield, w=w, na.rm=T, pad=T, fun=mean)
    yield<-crop(yield, aoi_big); yield<-mask(yield, aoi_big)
    plt(y=aoi, x=yield, main='yield -mean filtered', plot.results=plot.results)
  }
  }

#bilinear resampling to 10 m 
ndre75<-disagg(x=ndre75, fact=2, method='bilinear')
ndre75<-crop(ndre75, aoi); ndre75<-mask(ndre75, aoi)
plt(y=aoi, x=ndre75, main='ndre75 -resampled', plot.results=plot.results)
if(strategy=='useryieldmap'){
  yield<-resample(x=yield, y=ndre75)
  yield<-crop(yield, ndre75); yield<-mask(yield, ndre75)
  plt(y=aoi, x=yield, main='yield -resampled', plot.results=plot.results)
  }
if(strategy=='useryield'){ 
  yield<-ndre75
  values(yield)[!is.na(values(yield))]<-as.numeric(ymax)
  plt(y=aoi, x=yield, main='yield -resampled', plot.results=plot.results)
}

#test if rasters are aligned
if(strategy!='usermean')if(compareGeom(yield, ndre75)==FALSE)print("Yield raster and vegetation index raster are not aligned")

##prepare a data set to run onr model on 
if(strategy!='usermean'){
  df<-data.frame(ymax=values(yield))
  names(df)<-"ymax"
  df$nuptakemin<-as.numeric(nuptakemin)
}

#give feedback
print('Data have been prepared')