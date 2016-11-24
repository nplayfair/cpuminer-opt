#
# Dockerfile for cpuminer-opt
# usage: docker run creack/cpuminer --url xxxx --user xxxx --pass xxxx
# ex: docker run creack/cpuminer --url stratum+tcp://ltc.pool.com:80 --user creack.worker1 --pass abcdef
# Modified for cpuminer-opt by @nplayfair
#

FROM    ubuntu:16.04
MAINTAINER  Guillaume J. Charmes <guillaume@charmes.net>

ENV DEBIAN_FRONTEND noninteractive
RUN   apt-get update -qq

RUN   apt-get install -qqy automake
RUN   apt-get install -qqy libcurl4-openssl-dev
RUN   apt-get install -qqy git
RUN   apt-get install -qqy make
RUN   apt-get install -qqy libjansson-dev
RUN   apt-get install -qqy libgmp-dev
RUN   apt-get install -qqy libssl-dev
RUN   apt-get install -qqy libpthread-workqueue-dev
RUN   apt-get install -qqy zlib


RUN   git clone https://github.com/nplayfair/cpuminer-opt.git

RUN   cd cpuminer && ./autogen.sh
RUN   cd cpuminer && ./configure CFLAGS="-O3" CXXFLAGS="$CFLAGS -std=gnu++11"
RUN   cd cpuminer && make

WORKDIR   /cpuminer
ENTRYPOINT  ["./cpuminer"]
