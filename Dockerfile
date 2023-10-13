FROM witcherfuzz/python@sha256:b34f9ea50f66c33a12f3c94c289c969f6053364706cfa26b18b426c14bb3038e

USER root

### INSTALL CHRONIUM ###

RUN sed -i 's/archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list

RUN  apt-get update \
     && apt install unzip \
     && apt-get install -y --no-install-recommends wget gnupg ca-certificates \
     && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
     && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
     && apt-get update \
     && apt-get install -y --no-install-recommends google-chrome-stable \
     && rm -rf /var/lib/apt/lists/*

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/opt/google/chrome/chrome

USER wc

RUN sudo add-apt-repository ppa:ubuntu-toolchain-r/test
RUN sudo apt-get update
RUN sudo apt-get install libstdc++6 -y
RUN source /home/wc/.virtualenvs/pywitch/bin/activate && apt-get install python-dev libmysqlclient-dev python3-dev -y

RUN pip3 install flask flask_mysqldb requests

USER root


RUN rm -rf /helpers/request_crawler
RUN rm -rf /witcher
RUN rm -rf /helpers/phuzzer
RUN rm -rf /home/wc/.virtualenvs/witcher

COPY ./fuzzer-test /fuzzer-test
COPY ./request_crawler /helpers/request_crawler
COPY ./witcher_py /witcher
COPY ./phuzzer /helpers/phuzzer
COPY ./witcher_virtualenvs /home/wc/.virtualenvs/witcher
RUN chown -R wc:wc /home/wc/.virtualenvs/witcher && chmod 777 -R /home/wc/.virtualenvs/witcher

COPY init.sh /
RUN rm /httpreqr
COPY httpreqr /