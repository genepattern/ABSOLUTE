libdir = '/usr/local/bin/ABSOLUTE/'
patch.dir = '/patches'
server.dir='/usr/local/lib/R'
vers="2.15"
absol.library="/patches/rlib/2.15/site-library"
.libPaths(c(absol.library, .libPaths()))

source(file.path(libdir, "loadRLibrary.R"))
load.packages(libdir, patch.dir, server.dir, vers)

suppressPackageStartupMessages(library("ABSOLUTE", lib.loc = absol.library, character.only=TRUE))







