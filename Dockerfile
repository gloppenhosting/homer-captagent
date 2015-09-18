FROM debian:stable
MAINTAINER Andreas Krüger

# Install deps.
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -qq
RUN apt-get install -y libpcap0.8 automake libexpat1-dev libtool git  libpcap0.8-dev file
RUN apt-get install -y make

ENV captagent_version 0x00001
RUN git clone https://github.com/sipcapture/captagent.git
WORKDIR /captagent/captagent

RUN ./build.sh
RUN ./configure
RUN make
RUN make install

WORKDIR /
COPY captagent.xml /usr/local/etc/captagent/captagent.xml
COPY run.sh /

EXPOSE 8909
ENTRYPOINT [ "/run.sh" ]
