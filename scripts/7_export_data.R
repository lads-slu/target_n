#create output folder if it does not exist
if(!dir.exists(out.folder))dir.create(out.folder)

#export vra raster
fname<-file.path(out.folder, 'vra.tif')
writeRaster(vra, filename=fname, 
            filetype='GTiff', datatype='INT1U', NAflag=0, overwrite=T
            )

# export min, max and median values as text files
 fname<-fname<-file.path(out.folder, 'min.txt')
 write.table(x=n.min, file = fname, row.names = FALSE, sep="\t")
 
 fname<-fname<-file.path(out.folder, 'median.txt')
 write.table(x=n.median, file = fname, row.names = FALSE, sep="\t")
 
 fname<-fname<-file.path(out.folder, 'max.txt')
 write.table(x=n.max, file = fname, row.names = FALSE, sep="\t")
 
 #give feedback
 print('Data have been exported')