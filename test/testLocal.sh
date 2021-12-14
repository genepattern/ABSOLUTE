#params:
#       seg.dat.file: "<%gpunit.testData%>/gpunit/ABSOLUTE/v2/DRAWS_DRAWS_p_Sty11_Mapping250K_Sty_A01_66524.segdat.RData"
#       output.file.name.base: "<sample.name>"
#       sigma.p: "0"
#       max.sigma.h: "0.02"
#       min.ploidy: "0.95"
#       max.ploidy: "10"
#       primary.disease: "Breast Cancer"
#       platform: "SNP_250K_STY"
#       sample.name: "DRAWS_p_Sty11_Mapping250K_Sty_A01_66524"
#       max.as.seg.count: "1500"
#       max.neg.genome: "0"
#       max.non.clonal: "0"
#       copy.number.type: "allelic"
#       #can't be an empty string
#       #maf.file: ""
#       #min.mut.af: ""
# commandLine=Rscript --no-save --quiet --slave --no-restore /usr/local/bin/ABSOLUTE/run_absolute.R  --output.fn.base\=<output.file.name.base> --seg.dat.fn\=<seg.dat.file> --sigma.p\=<sigma.p> --max.sigma.h\=<max.sigma.h> --min.ploidy\=<min.ploidy> --max.ploidy\=<max.ploidy> --primary.disease\=<primary.disease> --platform\=<platform> --sample.name\=<sample.name> --max.as.seg.count\=<max.as.seg.count> --max.neg.genome\=<max.neg.genome> --max.non.clonal\=<max.non.clonal> --copy.number.type\=<copy.number.type> <maf.file> <min.mut.af>


docker run -w $PWD -v$PWD:$PWD -t genepattern/docker-absolute:latest Rscript --no-save --quiet --slave --no-restore /usr/local/bin/ABSOLUTE/run_absolute.R --output.fn.base="outputFilename"  --seg.dat.fn=$PWD/DRAWS_DRAWS_p_Sty11_Mapping250K_Sty_A01_66524.segdat.RData --sigma.p=0 --max.sigma.h=0.02 --min.ploidy=0.95 --max.ploidy=10 --primary.disease="Breast Cancer" --platform=SNP_250K_STY --sample.name=DRAWS_p_Sty11_Mapping250K_Sty_A01_66524 --max.as.seg.count=1500 --max.neg.genome=0 --max.non.clonal=0 --copy.number.type=allelic 




