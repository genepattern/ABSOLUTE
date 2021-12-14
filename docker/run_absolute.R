## The Broad Institute
## SOFTWARE COPYRIGHT NOTICE AGREEMENT
## This software and its documentation are copyright (2012) by the
## Broad Institute/Massachusetts Institute of Technology. All rights are
## reserved.
##
## This software is supplied without any warranty or guaranteed support
## whatsoever. Neither the Broad Institute nor MIT can be responsible for its
## use, misuse, or functionality.

# Bridging script to accept parameters from GenePattern and use them to call ABSOLUTE

# Load required libraries
suppressMessages(suppressWarnings(library(numDeriv)))
suppressMessages(suppressWarnings(library(getopt)))
suppressMessages(suppressWarnings(library(optparse)))
#suppressMessages(suppressWarnings(library(ABSOLUTE)))

absol.library="/patches/rlib/2.15/site-library"
suppressPackageStartupMessages(library("ABSOLUTE", lib.loc = absol.library, character.only=TRUE))



sessionInfo()

args <- commandArgs(trailingOnly=TRUE)

option_list <- list(
  make_option("--seg.dat.fn", dest="seg.dat.fn"),
  make_option("--sigma.p", dest="sigma.p"),
  make_option("--max.sigma.h", dest="max.sigma.h"),
  make_option("--min.ploidy", dest="min.ploidy"),
  make_option("--max.ploidy", dest="max.ploidy"),
  make_option("--primary.disease", dest="primary.disease"),
  make_option("--platform", dest="platform"),
  make_option("--sample.name", dest="sample.name"),
  make_option("--max.as.seg.count", dest="max.as.seg.count"),
  make_option("--max.non.clonal", dest="max.non.clonal"),
  make_option("--max.neg.genome", dest="max.neg.genome"),
  make_option("--copy.number.type", dest="copy.number.type"),
  make_option("--maf.fn", dest="maf.fn", default=NULL),
  make_option("--min.mut.af", dest="min.mut.af", default=NULL),
  make_option("--output.fn.base", dest="output.fn.base", default=NULL)
  )

opt <- parse_args(OptionParser(option_list=option_list), positional_arguments=TRUE, args=args)
print(opt)
opts <- opt$options

sigma.p <- as.numeric(opts$sigma.p)
if (is.na(sigma.p)) {
  stop("sigma.p must be a numeric value")
}

max.sigma.h <- as.numeric(opts$max.sigma.h)
if (is.na(max.sigma.h)) {
  stop("max.sigma.h must be a numeric value")
}

min.ploidy <- as.numeric(opts$min.ploidy)
if (is.na(min.ploidy)) {
  stop("min.ploidy must be a numeric value")
}

max.ploidy <- as.numeric(opts$max.ploidy)
if (is.na(max.ploidy)) {
  stop("max.ploidy must be a numeric value")
}

max.as.seg.count <- as.numeric(opts$max.as.seg.count)
if (is.na(max.as.seg.count)) {
  stop("max.as.seg.count must be a numeric value")
}

max.non.clonal <- as.numeric(opts$max.non.clonal)
if (is.na(max.non.clonal)) {
  stop("max.non.clonal must be a numeric value")
}

max.neg.genome <- as.numeric(opts$max.neg.genome)
if (is.na(max.neg.genome)) {
  stop("max.neg.genome must be a numeric value")
}

results.dir <- getwd()

# returns string w/o leading or trailing whitespace
trim <- function (x) gsub("^\\s+|\\s+$", "", x)

if (is.null(opts$maf.fn)) {
  maf.fn <- NULL
} else {
  maf.fn = trim(opts$maf.fn)
  if (maf.fn == "") {
    maf.fn <- NULL
  }
}

if (is.null(opts$min.mut.af)) {
  if (!is.null(maf.fn)) {
    stop("min.mut.af is required if a file is provided for maf.fn")
  }
  min.mut.af <- NULL
} else {
  min.mut.af <- as.numeric(opts$min.mut.af)
  if (is.na(min.mut.af)) {
    stop("min.mut.af must be a numeric value")
  }
}

if (is.null(opts$output.fn.base)) {
  output.fn.base <- opts$sample.name
} else {
  output.fn.base <- opts$output.fn.base
}

suppressWarnings(  # Done at JGentry's suggestion; R pkgs tend to put irrelevant output on stderr.

  RunAbsolute(opts$seg.dat.fn, sigma.p, max.sigma.h,
              min.ploidy, max.ploidy,
              opts$primary.disease, 
              opts$platform, opts$sample.name,
              results.dir, max.as.seg.count, 
              max.non.clonal, max.neg.genome, opts$copy.number.type,
              output.fn.base=output.fn.base, verbose=TRUE, 
              maf.fn=maf.fn, min.mut.af=min.mut.af)
)

sessionInfo()
