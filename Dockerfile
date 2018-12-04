FROM genepattern/docker-r-2-15:0.1

RUN mkdir /usr/local/bin/ABSOLUTE
RUN mkdir /usr/local/bin/ABSOLUTE/server_dir
RUN mkdir /patches
RUN mkdir -p /patches/rlib/2.15/site-library

COPY module/ /usr/local/bin/ABSOLUTE

RUN cp /usr/local/bin/ABSOLUTE/patches/ABSOLUTE_1.0.6.zip  /patches/rlib/2.15/site-library && \
    cd /patches/rlib/2.15/site-library  && \
    unzip ABSOLUTE_1.0.6.zip 

# ABSOLUTE_1.0.6.tgz	getopt_1.17.zip		numDeriv_2012.9-1.zip	optparse_0.9.5.zip

RUN    cp /usr/local/bin/ABSOLUTE/patches/getopt_1.17.zip  /patches/rlib/2.15/site-library && \
    cd /patches/rlib/2.15/site-library && \
    unzip getopt_1.17.zip && \
    cp /usr/local/bin/ABSOLUTE/patches/numDeriv_2012.9-1.zip  /patches/rlib/2.15/site-library && \
    unzip numDeriv_2012.9-1.zip && \
    cp /usr/local/bin/ABSOLUTE/patches/optparse_0.9.5.zip  /patches/rlib/2.15/site-library && \
    unzip optparse_0.9.5.zip 



RUN Rscript /usr/local/bin/ABSOLUTE/dockerLoadLibrary.R


