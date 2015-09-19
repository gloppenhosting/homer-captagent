FROM debian:stable
MAINTAINER Andreas Krüger
ENV DEBIAN_FRONTEND noninteractive
ENV captagent_version 0x00001

RUN apt-get update -qq
RUN apt-get install --no-install-recommends --no-install-suggests -yqq libpcap0.8 automake libexpat1-dev libtool git libpcap0.8-dev file make

WORKDIR /usr/src
RUN git clone https://github.com/sipcapture/captagent.git captagent

WORKDIR /usr/src/captagent
RUN ./build.sh
RUN ./configure
RUN make && make install

WORKDIR /
COPY captagent.xml /usr/local/etc/captagent/captagent.xml
COPY run.sh /

EXPOSE 8909
ENTRYPOINT [ "/run.sh" ]
