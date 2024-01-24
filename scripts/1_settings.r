#remove all objects
version
rm(list=ls())
args <- commandArgs(TRUE)

#find working directory
if(!'rstudioapi' %in% installed.packages())install.packages('rstudioapi')
wd<-dirname(rstudioapi::getSourceEditorContext()$path) #now it automatically finds the parent folder to folder where this script is saved

#prepare args vector (for SLU)
args<-c(
  wd, #working directory
  './test/VRA test/test2', #indatafolder
  50, #median
  'General', #cultivar (no longer used)
  'winterwheat', #crop c('maltingbarley', 'winterwheat')
  30, #min
  70, #max (no longer used)
  10, #resolution: 10 20 or 30 
  'useryield', #strategy  c('useryieldmap', 'usermean', 'useryield')
  FALSE, #rerun
  0, #n.min
  NA, #n.max
  8000, #ymax
  75 #nfertbefore
)

print("Parameters: ")
print(args)
print("END Parmeters")

#set working directory
setwd(args[1])

print('1.1');
print(Sys.time())

#define objects
##paths
yield.tif<-file.path(args[2],'yieldmap_out','yield_continuous.tif') #if there is no file, the script will handle use a uniform yield value
params.txt<-file.path(args[2],'yieldmap_out','params_continuous.txt') #if there is no file, the script will handle use a uniform yield value
ndre75.tif<-file.path(args[2],'vr2','ndre75.tif')
aoi.shape <- file.path(args[2],'vr2','aoi.shp') # polygon shape-file.
out.folder <-file.path(args[2],'out_8000_c') #folder to be created under working directory. All exported files are written to this folder.

##user settings
strategy<-args[9] #c('usermean', 'useryield', 'useryieldmap')
rerun<-args[10] #use FALSE for first run and TRUE for subsequent runs (to adjust min, mean and max values)
crop<-args[5] #'winterwheat' or 'maltingbarley'
cultivar<- args[4] #see scripts\\modelcoeffs.txt which cultivars shall be available for different crops (include those with parameter values)
n.min <- as.numeric(args[6]) # NA or a number , minimum nrate for the field (kg ha-1) from the user. If NA n.min will be set to max(0, smallest predicted nrate)
n.median <- as.numeric(args[3]) # NA or a number, median nrate for the field (kg ha-1) from the user. If NA no adjustment will be done.
n.max <- as.numeric(args[7]) #  NA or a number, maximum  nrate for the field (kg ha-1) from the user. If NA n.max will be set to min(2*n.median, largest predicted nrate)
res<-as.numeric(args[8]) #resolution of output raster: 10, 20 or 30
nuptakemin<-args[11] #N uptake in zeroplot (kg N per ha). NA or a number
nuptakemax<-args[12] #N uptake in maxplot (kg N per ha). NA or a number
ymax<-args[13] #Yield potential (kg grains per ha).NA or a number
nfertbefore<-args[14] #N fertilization earlier in the season (kg N per ha). NA or a number).

##other settings (ignore for now)
mean.filter<-1 #0 or 1, 0=no 1=yes. Currently overwritten by script 5.
#index.cutoff<-NA # NA or a number. Below this value nrate is set to n.cutoff. If NA the 5-percentile of the index will be used.
#n.cutoff<-10 #  NA or a number. The nrate that is set when index< index.cutoff. I
plot.results<-TRUE #Use TRUE for plotting in R console, else FALSE
print('1.3');
print(Sys.time())

##run all
source('scripts\\2_run_all.r')

###Note:
#All spatial datasets must be projected onto the coordinate system EPSG:3006

