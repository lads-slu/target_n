#remove all objects
rm(list=ls())

#set working directory
if(!'rstudioapi' %in% installed.packages())install.packages('rstudioapi')

#define objects
##paths
yield.tif<-file.path('in', 'yield' , 'yield_continuous.tif') #if there is no file, the script will handle use a uniform yield value
ndre75.tif<-file.path('in','index','ndre75.tif')
aoi.shape <- file.path('in','aoi','aoi.shp') # polygon shape-file.
out.folder <-file.path('out') #folder to be created under working directory. All exported files are written to this folder.

##user settings
strategy<-'usermean' #c('usermean', 'useryield', 'useryieldmap')
rerun<-TRUE #use FALSE for first run and TRUE for subsequent runs (to adjust min, mean and max values)
crop<-'winterwheat' #'winterwheat' or 'maltingbarley'
n.min <- 30 # NA or a number , minimum nrate for the field (kg ha-1) from the user. If NA n.min will be set to max(0, smallest predicted nrate)
n.median <- 50 # NA or a number, median nrate for the field (kg ha-1) from the user. If NA no adjustment will be done.
n.max <- 70 #  NA or a number, maximum  nrate for the field (kg ha-1) from the user. If NA n.max will be set to min(2*n.median, largest predicted nrate)
res<-20 #resolution of output raster: 10, 20 or 30
nuptakemin<-30 #N uptake in zero plot (kg N per ha). NA or a number
ymax<-8000 #Yield potential (kg grains per ha).NA or a number
nfertbefore<-50 #N fertilization earlier in the season (kg N per ha). NA or a number).
plot.results<-TRUE  #shall maps be plotted in the R console

#run all
source('scripts\\2_load_packages.r')
source('scripts\\3_define_functions.r')
source('scripts\\4_import_data.r')
source('scripts\\5_prepare_data.r')
source('scripts\\6_create_vra_map.r')
source('scripts\\7_export_data.r')

###Note:
#All spatial datasets must be projected onto the coordinate system EPSG:3006