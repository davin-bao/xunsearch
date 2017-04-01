FROM centos:7

MAINTAINER Davin <davin.bao@gmail.com>

ENV XUNSEARCH_VERSION 1.4.10

RUN set -xe \
    && yum -y update

RUN set -xe \
    && yum install -y curl \
        make \
        gcc \
        g++ \
        bzip2 \
        zlib-devel \
        glibc-headers \
        gcc-c++

RUN set -xe \
    cd /usr/src \
    && curl -fSL  "http://www.xunsearch.com/download/xunsearch-full/xunsearch-full-1.4.10.tar.bz2" -o xunsearch.tar.bz2 \
    && pwd && ls -l\
    && mkdir -p /usr/src/xunsearch \
    && tar -vxjf xunsearch.tar.bz2 -C /usr/src/xunsearch --strip-components=1 \
    && rm xunsearch.tar.bz2 \
    && cd /usr/src/xunsearch \
    && sh setup.sh --prefix=/usr/local/xunsearch \
    && cp /usr/local/xunsearch/bin/xs-ctl.sh /usr/local/bin


VOLUME /usr/local/xunsearch/data

WORKDIR /usr/local/xunsearch

RUN chmod +x /usr/local/bin/xs-ctl.sh


EXPOSE 8383 8384

RUN echo "#!/bin/sh" > bin/xs-docker.sh
RUN echo "echo -n > tmp/docker.log" >> bin/xs-docker.sh
RUN echo "bin/xs-indexd -b 8383 -l tmp/docker.log -k start" >> bin/xs-docker.sh
RUN echo "sleep 1" >> bin/xs-docker.sh
RUN echo "bin/xs-searchd -b 8384 -l tmp/docker.log -k start" >> bin/xs-docker.sh
RUN echo "sleep 1" >> bin/xs-docker.sh
RUN echo "tail -f tmp/docker.log" >> bin/xs-docker.sh

ENTRYPOINT ["sh"]
CMD ["bin/xs-docker.sh"]
