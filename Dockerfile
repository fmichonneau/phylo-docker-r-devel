## Emacs, make this -*- mode: sh; -*-

## Modified from rocker/hadleyverse

FROM rocker/r-devel

MAINTAINER "Francois Michonneau" francois.michonneau@gmail.com

RUN apt-get update \
    && apt-get install -t unstable -y --no-install-recommends \
	       aspell \
	       aspell-en \
	       ghostscript \
	       imagemagick \
	       lmodern \
	       pandoc \
	       pandoc-citeproc \
	       texlive-fonts-recommended \
	       texlive-humanities \
	       texlive-latex-extra \
	       texinfo \
    && apt-get clean \
    #&& cd /usr/share/texlive/texmf-dist \
    #&& wget http://mirrors.ctan.org/install/fonts/inconsolata.tds.zip \
    #&& unzip inconsolata.tds.zip \
    #&& rm inconsolata.tds.zip \
    #&& echo "Map zi4.map" >> /usr/share/texlive/texmf-dist/web2c/updmap.cfg \
    && mktexlsr \
    && updmap-sys

## Install some external dependencies.
RUN apt-get update \
    && apt-get install -y --no-install-recommends -t unstable \
	       default-jdk \
	       default-jre \
	       gdal-bin \
	       icedtea-netx \
	       libatlas-base-dev \
	       libcairo2-dev \
	       libgsl0-dev \
	       libgdal1-dev \
	       libgeos-dev \
	       libgeos-c1v5 \
	       librdf0-dev \
	       libssl-dev \
	       libmysqlclient-dev \
	       libpq-dev \
	       libsqlite3-dev \
	       libv8-dev \
	       libxcb1-dev \
	       libxdmcp-dev \
	       libxml2-dev \
	       libxslt1-dev \
	       libxt-dev \
	       netcdf-bin \
	       qpdf \
	       r-cran-rgl \
	       ssh \
	       vim \
    && R CMD javareconf

## Install needed dependencies

RUN install2.r --error \
    devtools \
    git2r \
    knitr \
    rmarkdown \
    testthat \
    xml2

RUN install2.r --error \
    -r "https://cran.rstudio.com" \
    -r "http://www.bioconductor.org/packages/release/bioc" \
    ade4 \
    ape  \
    aRxiv \
    assertthat \
    bibtex \
    bitops \
    bold \
    brew \
    caTools \
    chron \
    coda \
    colorspace \
    corpcor \
    crayon \
    cubature \
    data.table \
    DBI \
    devtools \
    dichromat \
    dplyr \
    foreach \
    formatR \
    fulltext \
    ggplot2 \
    gdata \
    git2r \
    gtable \
    highr \
    iterators \
    labeling \
    lattice \
    lubridate \
    markdown \
    MCMCglmm \
    memoise  \
    munsell \
    nlme \
    NLP \
    nnet \
    phylobase \
    plyr \
    praise \
    R.cache \
    R.methodsS3 \
    R.oo \
    R.utils \
    RColorBrewer \
    Rcpp \
    readxl \
    rentrez \
    reshape \
    reshape2 \
    rex \
    rjson \
    rmarkdown \
    RNeXML \
    rncl \
    roxygen2 \
    rotl \
    rplos \
    rredis \
    rstudioapi \
    rversions \
    scales \
    slam \
    solr \
    survival \
    taxize \
    tensorA \
    tidyr \
    tm   \
    uuid \
    XML \
    yaml \
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

## For some reason, lattice in non standard location is also needed:
RUN install2.r lattice -l /usr/local/lib/R/library/

## httr authentication uses this port
EXPOSE 1410
ENV HTTR_LOCALHOST 0.0.00.
