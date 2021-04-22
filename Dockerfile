RUN add-apt-repository ppa:ubuntugis/ppa -y && \
    apt-get update && \
    apt-get install --fix-missing -y grass=7.8.0-1~bionic1 grass-dev=7.8.0-1~bionic1 && \
    echo "1" >/usr/lib/grass78/docs/html/grass_logo.png && \
    echo "1" >/usr/lib/grass78/docs/html/grassdocs.css && \
