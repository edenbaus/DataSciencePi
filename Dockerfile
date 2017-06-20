# Pull base image
FROM resin/rpi-raspbian:wheezy
MAINTAINER Dieter Reuter <dieter@hypriot.com>

# Install dependencies
RUN echo 'deb http://mirrordirector.raspbian.org/raspbian/ stretch main contrib non-free rpi' > /etc/apt/sources.list

RUN apt-get update && apt-get install -y \
    python3 \
    python3-dev \
    cython3 \
    python3-cffi \
    python3-setuptools \
    python3-pip \
    pkg-config \
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

RUN mkdir -p pyapp
COPY requirements.txt pyapp/
RUN pip3 install --upgrade pip
RUN pip3 install -r pyapp/requirements.txt

#setup R
RUN echo "r <- getOption('repos'); r['CRAN'] <- 'http://cran.us.r-project.org'; options(repos = r);" > ~/.Rprofile
RUN Rscript -e "install.packages('yhatr')"
RUN Rscript -e "install.packages('ggplot2')"
RUN Rscript -e "install.packages('googleVis')"
RUN Rscript -e "install.packages('Outliers')"
RUN Rscript -e "install.packages(c('features','Hmisc','party', 'ISLR','mice','NLP','foreign'))"
RUN Rscript -e "install.packages('tm')"
RUN Rscript -e "install.packages(c('CCP','RColorBrewer','colorspace','highr','evaluate','zoo','gtable','RcppEigen','yaml','BH','mtvnorm'))"
RUN Rscript -e "install.packages(c('LSMeans','Comparison','RegTest','ACD','BinomTools','DAIM','ClustEval','SigClust','PROC','TimeROC'))"
RUN Rscript -e "install.packages(c('car','RMiner','CoreLearn','caret','BigRF','CBA','RankCluster','LTSA','survival','Basta'))"
RUN Rscript -e "install.packages(c('RMarkdown','qcc','jsonlite','RCurl','RWeka','parallel','Rcpp','twitteR'))"
RUN Rscript -e "install.packages(c('igraph','nnet','glmnet','tree','arules','earth','mboost','CORElearn','ipred','klaR','party','ROCR','kernlab'))"
RUN Rscript -e "install.packages('wordcloud')"
RUN Rscript -e "install.packages(c('MissForest','MissMDA'))"
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
RUN Rscript -e "install.packages(c('repr', 'IRdisplay', 'crayon', 'pbdZMQ', 'devtools'))"

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
