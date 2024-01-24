#create output folder if it does not exist
print('7.1 Create output folder')
if(!dir.exists(out.folder))dir.create(out.folder)

print('7.2 Export raster')
#export vra raster
fname<-paste0(out.folder, 'vra.tif')
writeRaster(vra, 
            filename=fname, 
            filetype='GTiff', 
            datatype='INT1U', 
            NAflag=0, 
            overwrite=T)

# #export vra raster
# fname<-paste0(out.folder, 'nreq.tif')
# suppressWarnings(
#   writeRaster(nreq, filename=fname, 
#               filetype='GTiff', datatype='INT2S', NAflag=0, overwrite=T)
# )
# 
# #export vra raster
#  fname<-paste0(out.folder, 'nreqr.tif')
#  suppressWarnings(
#    writeRaster(nreqr, filename=fname, 
#                filetype='GTiff', datatype='INT2S', NAflag=0, overwrite=T)
#  )
 
# print('7.3 Export text-file')
# export min, max and median values as text files
 fname<-fname<-paste0(out.folder, 'min.txt')
 write.table(x=n.min, file = fname, row.names = FALSE, sep="\t")
 fname<-fname<-paste0(out.folder, 'median.txt')
 write.table(x=n.median, file = fname, row.names = FALSE, sep="\t")
 fname<-fname<-paste0(out.folder, 'max.txt')
 write.table(x=n.max, file = fname, row.names = FALSE, sep="\t")

#give feedback
print('Data have been exported')
print('Ready')
