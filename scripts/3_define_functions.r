#define function for plotting
plt<-function(x, y, main, plot.results){
  if(plot.results){
    plot(y, main=main)
    plot(x,add=T)
    plot(y, main=main, add=T)
  }
}

#give feedback
print('Functions have been defined')