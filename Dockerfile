# Pull base image
FROM resin/rpi-raspbian:wheezy
MAINTAINER Scott Edenbaum <scott.edenbaum@gmail.com>

# Install dependencies
RUN echo 'deb http://mirrordirector.raspbian.org/raspbian/ stretch main contrib non-free rpi' > /etc/apt/sources.list

RUN apt-get update && apt-get install -y \
    curl \
    wget \
    screen \
    cmake \
    unzip \
    libtiff5-dev \
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
    libjasper-dev \
    libavcodec-dev \
    libswscale-dev \
    libv4l-dev \
    libxvidcore-dev \
    libx264-dev \
    libatlas-base-dev \
    libfreetype6-dev\
    libxft-dev \
    libblas-dev \
    liblapack-dev \
    libatlas-base-dev \
    gfortran \
    libxml2-dev \
    libxslt-dev \
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


###### install opencv
# RUN cd /tmp && \
#     wget -O opencv.zip https://github.com/opencv/opencv/archive/3.2.0.zip && \
#     unzip opencv.zip && \
#     wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/3.2.0.zip && \
#     unzip opencv_contrib.zip

# build opencv
# RUN cd /tmp/opencv-3.2.0 && \
#     mkdir build && \
#     cd build && \
#     cmake -D CMAKE_BUILD_TYPE=RELEASE \
#     -D CMAKE_INSTALL_PREFIX=/usr/local \
#     -D INSTALL_C_EXAMPLES=ON \
#     -D BUILD_PYTHON_SUPPORT=ON \
#     -D BUILD_NEW_PYTHON_SUPPORT=ON \
#     -D INSTALL_PYTHON_EXAMPLES=ON \
#         -D OPENCV_EXTRA_MODULES_PATH=/tmp/opencv_contrib-3.2.0/modules \
#     -D BUILD_EXAMPLES=ON .. && \
#     make -j4 && \
#     make && \
#     make install && \
#     make clean
# 
# # cleanup source
# RUN cd /tmp && rm -rf opencv-3.2.0


RUN mkdir -p pyapp
COPY requirements*.txt pyapp/
RUN pip3 install --upgrade pip
RUN pip3 install -r pyapp/requirements.txt
RUN pip3 install -r pyapp/requirements2.txt
#setup R
RUN echo "r <- getOption('repos'); r['CRAN'] <- 'http://cran.us.r-project.org'; options(repos = r);" > ~/.Rprofile
RUN Rscript -e "install.packages(c('yhatr','rpart.plot','lattice','mlogit','moments','MNP','muhaz','tidytext','text2vec'))"
RUN Rscript -e "install.packages(c('LDAvis','mcmc','syuzhet','SnowballC','gmodels','descr','ggplot2','googleVis'))"
RUN Rscript -e "install.packages(c('outliers','features','Hmisc','party','ISLR','mice','NLP','foreign','tm','CCP'))"
RUN Rscript -e "install.packages(c('RColorBrewer','colorspace','highr','evaluate','zoo','quantmod','TTR','fAssets'))"
RUN Rscript -e "install.packages(c('Bioconductor','Quandl','zipcode','treemap','worldmap','ellipse'))"
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

RUN pip3 install statsmodels

USER root
CMD jupyter-lab --ip 0.0.0.0  --port 9999 --LabApp.token='' --allow-root
