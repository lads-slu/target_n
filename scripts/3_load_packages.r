print('3')
r = getOption("repos")
r["CRAN"] = "http://cran.us.r-project.org"
options(repos = r)

print('3.1')
 
#install required packages that are not yet installed
pkgs <- c("terra")
sel <- !pkgs %in% rownames(installed.packages())
if(any(sel)){install.packages(pkgs[sel])}
invisible(lapply(X=pkgs, FUN=require, character.only = TRUE))


#give feedback
print('Required packages have been loaded')

