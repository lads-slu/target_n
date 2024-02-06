if(strategy!='usermean'){
  #compute mean remaining N requirement
  ##temporary fix
  if(crop=='winterwheat'){# yield potential plus zeroplot
    df$onr<- 43.1+20-2.27*df$nuptakemin+0.0198*(df$ymax + 610) # plus 610 kg per ha because target yield (expected yield at optimum, which is presumably what users will use, is on average 610kg per ha lower than the maximum possible yield)
  } 
  if(crop=='maltingbarley'){# yield potential plus zeroplot
    df$onr<- 26.4+20-2.15*df$nuptakemin+0.0223*(df$ymax + 150)
  } 
  df$nreq<-df$onr
  df$nreq[df$nreq<0]<-0
  nreq<-yield
  values(nreq)<-df$nreq
} else{
  nreq<-ndre75
  values(nreq)[!is.na(values(nreq))]<-n.median
}

#prepare raster for fertilization earlier in the season
nfert<-ndre75
values(nfert)[!is.na(values(nfert))]<-as.numeric(nfertbefore)

#compute vra
ndre75r<-ndre75-as.numeric(global(ndre75, median, na.rm=T))
##temporary fix
if(crop=='winterwheat'){
  # coefficients from ECPA in Bologna (Kristin's note: C:\ki\projekt\target_n\analyses\10_final_report\data_and_scripts2\xls\nreqrpreds.xls)
  nreqr<-(-5.70e+02)*ndre75r  #decided to skip intercept (2.74e-01), which is close to zero anyway. In theory, it is better that it is zero. 
} 
if(crop=='maltingbarley'){
  nreqr<-(-5.66e+02)*ndre75r   #se above, intercept =(-3.79e+00)
} 
if(strategy!='usermean'){
  vra<-nreq+nreqr-nfert} else{
    vra<-n.median+nreqr
  }
vra[vra<=0]<-0

if(mean.filter & strategy=='useryieldmap'){
  vra<-crop(vra, aoi); vra<-mask(vra, aoi_small)
  vra<-extend(x=vra, y=aoi_big, fill=NA)
  vra<-focal(vra, w, na.rm=T, pad=T, fun=mean)
  vra<-crop(vra, aoi_big); vra<-mask(vra, aoi_big)
  plt(y=aoi, x=vra, main='vra -mean filtered', plot.results=plot.results)
}  

plt(y=aoi, x=nreq, main='nreq', plot.results=plot.results)
plt(y=aoi, x=nreqr, main='nreqr', plot.results=plot.results)
plt(y=aoi, x=vra, main='nrate', plot.results=plot.results)


if(rerun){
  ##adjust level so that nrate median is equal to n.median
  vra<-vra + n.median-median(values(vra), na.rm=T) 
  plt(y=aoi, x=vra, main='nrate -median adjusted', plot.results=plot.results)
  
  #adjust min
  if(!is.na(n.min)){
    n.min<-round(max(0, n.min, min(values(vra), na.rm=T)))
    vra[vra<n.min]<-n.min
  }
  #adjust max (if user has specified it)
  if(!is.na(n.max)){
    n.max<-round(min(n.max, max(values(vra), na.rm=T)))
    vra[vra>n.max]<-n.max
  }
  plt(y=aoi, x=vra, main='nrate -min and max adjusted', plot.results=plot.results)
}

#set any negative nrates to 0
values(vra)[values(vra)<0]<-0

#aggregate raster if res>10
if(res>10)vra<-aggregate(x=vra, fact=res/10)
vra<-crop(vra, aoi)
vra<-mask(vra, aoi)
plt(y=aoi, x=vra, main='nrate -aggregated', plot.results=plot.results)
if(res==10&plot.results)plot(values(ndre75), values(vra))

a<-values(vra)
high<-quantile(a, 0.975, na.rm=T, names=F)
low<-quantile(a, 0.025, na.rm=T, names=F)
a[a>=high]<-high
a[a<=low]<-low
values(vra)<-a
plt(y=aoi, x=vra, main='nrate -trimmed', plot.results=plot.results)
if(res==10&plot.results)plot(values(ndre75), values(vra))

n.min<-min(values(vra), na.rm=T)
n.median<-median(values(vra), na.rm=T)
n.max<-max(values(vra), na.rm=T)

#give feedback
print('nrate map has been calculated')