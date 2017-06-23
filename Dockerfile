# Pull base image
FROM resin/rpi-raspbian:wheezy
MAINTAINER Dieter Reuter <dieter@hypriot.com>

# Install dependencies
RUN echo 'deb http://mirrordirector.raspbian.org/raspbian/ stretch main contrib non-free rpi' > /etc/apt/sources.list

RUN apt-get update && apt-get install -y \
    libhdf5-dev \
    python3 \
    python3-dev \
    cython3 \
    python3-cffi \
    python3-setuptools \
    python3-pip \
    pkg-config \
    python3-tables \
    python3-wheel \
    python3-numpy \
    python3-scipy \
    libpng-dev \
    libfreetype6-dev\
    libxft-dev \
    libblas-dev \
    liblapack-dev \
    libatlas-base-dev \
    gfortran \
    libxml2-dev \
    libxslt-dev \
    python-virtualenv \
    python-setuptools \
    build-essential \
    ipython3 \
    libncurses5-dev \
    libssl-dev \
    openssl \
    libreadline-dev \
    libbz2-dev \
    libncurses5-dev \
    libcurl4-openssl-dev \
    libjpeg-dev \
    r-base \
    r-base-core \
    r-base-dev \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

#RUN apt-get update && apt-get install -y libgeos-c1

RUN mkdir -p pyapp
COPY requirements*.txt pyapp/
RUN pip3 install --upgrade pip
RUN pip3 install -r pyapp/requirements.txt
RUN pip3 install -r pyapp/requirements2.txt
#setup R
RUN echo "r <- getOption('repos'); r['CRAN'] <- 'http://cran.us.r-project.org'; options(repos = r);" > ~/.Rprofile
RUN Rscript -e "install.packages('yhatr')"
RUN Rscript -e "install.packages('gmodels')"
RUN Rscript -e "install.packages('descr')"
RUN Rscript -e "install.packages('ggplot2')"
RUN Rscript -e "install.packages('googleVis')"
RUN Rscript -e "install.packages('Outliers')"
RUN Rscript -e "install.packages('features')"
RUN Rscript -e "install.packages('Hmisc')"
RUN Rscript -e "install.packages('party')"
RUN Rscript -e "install.packages('ISLR')"
RUN Rscript -e "install.packages('mice')"
RUN Rscript -e "install.packages('NLP')"
RUN Rscript -e "install.packages('foreign')"
RUN Rscript -e "install.packages('tm')"
RUN Rscript -e "install.packages('CCP')"
RUN Rscript -e "install.packages('RColorBrewer')"
RUN Rscript -e "install.packages('colorspace')"
RUN Rscript -e "install.packages('highr')"
RUN Rscript -e "install.packages('evaluate')"
RUN Rscript -e "install.packages('zoo')"
RUN Rscript -e "install.packages('gtable')"
RUN Rscript -e "install.packages('RcppEigen')"
RUN Rscript -e "install.packages('yaml')"
RUN Rscript -e "install.packages('BH')"
RUN Rscript -e "install.packages('mtvnorm')"
RUN Rscript -e "install.packages('LSMeans')"
RUN Rscript -e "install.packages('Comparison')"
RUN Rscript -e "install.packages('RegTest')"
RUN Rscript -e "install.packages('ACD')"
RUN Rscript -e "install.packages('BinomTools')"
RUN Rscript -e "install.packages('DAIM')"
RUN Rscript -e "install.packages('ClustEval')"
RUN Rscript -e "install.packages('SigClust')"
RUN Rscript -e "install.packages('PROC')"
RUN Rscript -e "install.packages('TimeROC')"
RUN Rscript -e "install.packages('car')"
RUN Rscript -e "install.packages('RMiner')"
RUN Rscript -e "install.packages('CoreLearn')"
RUN Rscript -e "install.packages('caret')"
RUN Rscript -e "install.packages('BigRF')"
RUN Rscript -e "install.packages('CBA')"
RUN Rscript -e "install.packages('RankCluster')"
RUN Rscript -e "install.packages('LTSA')"
RUN Rscript -e "install.packages('survival')"
RUN Rscript -e "install.packages('Basta')"
RUN Rscript -e "install.packages('RMarkdown')"
RUN Rscript -e "install.packages('qcc')"
RUN Rscript -e "install.packages('jsonlite')"
RUN Rscript -e "install.packages('RCurl')"
RUN Rscript -e "install.packages('RWeka')"
RUN Rscript -e "install.packages('parallel')"
RUN Rscript -e "install.packages('Rcpp')"
RUN Rscript -e "install.packages('twitteR')"
RUN Rscript -e "install.packages('igraph')"
RUN Rscript -e "install.packages('nnet')"
RUN Rscript -e "install.packages('glmnet')"
RUN Rscript -e "install.packages('tree')"
RUN Rscript -e "install.packages('arules')"
RUN Rscript -e "install.packages('earth')"
RUN Rscript -e "install.packages('mboost')"
RUN Rscript -e "install.packages('CORElearn')"
RUN Rscript -e "install.packages('ipred')"
RUN Rscript -e "install.packages('klaR')"
RUN Rscript -e "install.packages('party')"
RUN Rscript -e "install.packages('ROCR')"
RUN Rscript -e "install.packages('kernlab')"
RUN Rscript -e "install.packages('wordcloud')"
RUN Rscript -e "install.packages('MissForest')"
RUN Rscript -e "install.packages('MissMDA')"
RUN Rscript -e "install.packages('data.table')"
RUN Rscript -e "install.packages('sqldf')"
RUN Rscript -e "install.packages('forecast')"
RUN Rscript -e "install.packages('RMYSQL')"
RUN Rscript -e "install.packages('MASS')"
RUN Rscript -e "install.packages('dplyr')"
RUN Rscript -e "install.packages('reshape2')"
RUN Rscript -e "install.packages('forecast')"
RUN Rscript -e "install.packages('stringr')"
RUN Rscript -e "install.packages('lubridate')"
RUN Rscript -e "install.packages('randomForest')"
RUN Rscript -e "install.packages('rpart')"
RUN Rscript -e "install.packages('e1071')"
RUN Rscript -e "install.packages('kknn')"
RUN Rscript -e "install.packages('plyr')"
RUN Rscript -e "install.packages('repr')"
RUN Rscript -e "install.packages('IRdisplay')"
RUN Rscript -e "install.packages('crayon')"
RUN Rscript -e "install.packages('pbdZMQ')"
RUN Rscript -e "install.packages('devtools')"

RUN R -e "install.packages(('devtools'), repos='https://cloud.r-project.org'); devtools::install_github('IRkernel/IRkernel'); IRkernel::installspec()" #Rscript -e "install.packages('devtools')"

RUN echo "root:Docker!" | chpasswd
RUN useradd -m -G sudo,users student
RUN echo "student:Docker!" | chpasswd

RUN chown student /home/student
# Define working directory
WORKDIR /home/student

# Define default command

USER root
CMD jupyter-lab --ip 0.0.0.0  --port 9999 --LabApp.token='' --allow-root
