FROM ubuntu:xenial

# install only the packages that are needed
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    software-properties-common python-software-properties \
    ca-certificates \
    git \
    make \
    liblapack-dev \
    wget \
    vim

RUN add-apt-repository ppa:ubuntugis/ppa -y && \
    apt-get update && \
    apt-get install --fix-missing -y grass=7.8.0-1~bionic1 grass-dev=7.8.0-1~bionic1 && \
    echo "1" >/usr/lib/grass78/docs/html/grass_logo.png && \
    echo "1" >/usr/lib/grass78/docs/html/grassdocs.css && \
    
###################################
# Python 3.7 (Install py37 conda to avoid mpi4py issue, see below)
RUN wget https://repo.continuum.io/miniconda/Miniconda3-py37_4.8.3-Linux-x86_64.sh \
    && bash Miniconda3-py37_4.8.3-Linux-x86_64.sh -b -p /opt/miniconda3 \
    && rm Miniconda3-py37_4.8.3-Linux-x86_64.sh \
    && chown -R docker:docker /opt/miniconda3

RUN R --slave -e 'install.packages("sp")'  \
    R --slave -e 'install.packages("XML")'  \
    R --slave -e 'install.packages("rgdal")'  \
    R --slave -e 'install.packages("remotes")'  \
    R --slave -e 'install.packages("rgrass7")'  \
    R --slave -e 'install.packages("units")'  \
    R --slave -e 'install.packages("sf")'  \
    R --slave -e 'install.packages("stars")'  \
    R --slave -e 'install.packages("openssl")'  \
    R --slave -e 'install.packages("curl")'  \
    R --slave -e 'install.packages("httr")'  \
    R --slave -e 'install.packages("devtools")'
    
RUN python config/setup.py
