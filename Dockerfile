#
# Dockerfile for cpuminer-opt
# usage: docker run creack/cpuminer --url xxxx --user xxxx --pass xxxx
# ex: docker run creack/cpuminer --url stratum+tcp://ltc.pool.com:80 --user creack.worker1 --pass abcdef
# Modified for cpuminer-opt by @nplayfair
#

FROM    ubuntu:14.04
MAINTAINER  Guillaume J. Charmes <guillaume@charmes.net>

ENV DEBIAN_FRONTEND noninteractive
RUN   apt-get update -qq

RUN   apt-get install -qqy automake libcurl4-openssl-dev git make g++ libjansson-dev libgmp-dev libtool libssl-dev
#RUN   apt-get install -qqy libcurl4-openssl-dev
#RUN   apt-get install -qqy git-core
#RUN   apt-get install -qqy make
#RUN   apt-get install -qqy libjansson-dev
#RUN   apt-get install -qqy libgmp-dev
#RUN   apt-get install -qqy libssl-dev
#RUN   apt-get install -qqy libpthread-workqueue-dev
#RUN   apt-get install -qqy zlibc


RUN   git clone https://github.com/nplayfair/cpuminer-opt.git

RUN   cd cpuminer-opt && mkdir m4 && ./autogen.sh && \
      CFLAGS="-O3 -march=native -Wall" CXXFLAGS="$CFLAGS -std=gnu++11" ./configure --with-curl && \
      make -j4 && strip -s cpuminer

WORKDIR   /cpuminer-opt
ENTRYPOINT  ["./cpuminer"]
