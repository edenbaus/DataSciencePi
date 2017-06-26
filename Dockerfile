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
RUN Rscript -e "install.packages('rpart.plot')"
RUN Rscript -e "install.packages('lattice')"
RUN Rscript -e "install.packages('mlogit')"
RUN Rscript -e "install.packages('moments')"
RUN Rscript -e "install.packages('MNP')"
RUN Rscript -e "install.packages('muhaz')"
RUN Rscript -e "install.packages('tidytext')"
RUN Rscript -e "install.packages('text2vec')"
RUN Rscript -e "install.packages('LDAvis')"
RUN Rscript -e "install.packages('mcmc')"
RUN Rscript -e "install.packages('syuzhet')"
RUN Rscript -e "install.packages('SnowballC')"
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
RUN Rscript -e "install.packages('quantmod')"
RUN Rscript -e "install.packages('TTR')"
RUN Rscript -e "install.packages('fAssets')"
RUN Rscript -e "install.packages('Bioconductor')"
RUN Rscript -e "install.packages(c('Leaflet','ggmap','swirl','gtable','RcppEigen','yaml','BH','mtvnorm'))"
RUN Rscript -e "install.packages(c('LSMeans','Comparison','RegTest','ACD','BinomTools','DAIM','ClustEval','SigClust','PROC'))"
RUN Rscript -e "install.packages(c('TimeROC','car','RMiner','CoreLearn','caret','BigRF','CBA','RankCluster'))"
RUN Rscript -e "install.packages(c('LTSA','survival','Basta','RMarkdown','qcc','jsonlite','RCurl','RWeka'))"
RUN Rscript -e "install.packages(c('parallel','Rcpp','twitteR','igraph','nnet','glmnet','tree','arules','earth','mboost'))"
RUN Rscript -e "install.packages(c('CORElearn','ipred','klaR','party','ROCR','kernlab','wordcloud','MissForest','MissMDA'))"
RUN Rscript -e "install.packages(c('data.table','sqldf','forecast','RMYSQL','anomalyDetection','ElemStatLearn','h2o'))"
RUN Rscript -e "install.packages(c('MASS','penalized','dplyr','reshape2','forecast','stringr','sampleSelection','sandwich'))"
RUN Rscript -e "install.packages(c('sem','statnet','topicmodels','vcd','broom','corrplot','rbokeh','rCharts','lubridate'))"
RUN Rscript -e "install.packages(c('randomForest','rpart','e1071','kknn','plyr','repr','IRdisplay','crayon','pdbZMQ'))"
RUN Rscript -e "install.packages(c('magrittr', 'doBy','extrafont','chunked','snda','network','visNetwork','devtools'))"
RUN Rscript -e "install.packages(c('angstroms','bikedata','datasuRus','dwapi','HURDAT','neurohcp','omsdata','parlitools'))"
RUN Rscript -e "install.packages(c('rerddap','soilcarbon','learnr','olsrr','rODE'))"


RUN R -e "install.packages(('devtools'), repos='https://cloud.r-project.org'); devtools::install_github('IRkernel/IRkernel');devtools::install_github('skoval/deuce');IRkernel::installspec()" #Rscript -e "install.packages('devtools')"

RUN echo "root:Docker!" | chpasswd
#RUN useradd -m -G sudo,users student
#RUN echo "student:Docker!" | chpasswd
#RUN chown student /home/student
# Define working directory
WORKDIR /home/student

# Define default command

USER root
CMD jupyter-lab --ip 0.0.0.0  --port 9999 --LabApp.token='' --allow-root
