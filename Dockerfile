FROM ubuntu:20.04

MAINTAINER <christoph.hahn@uni-graz.at>

WORKDIR /usr/src

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true
## preesed tzdata, update package index, upgrade packages and install needed software
RUN echo "tzdata tzdata/Areas select Europe" > /tmp/preseed.txt; \
	echo "tzdata tzdata/Zones/Europe select Vienna" >> /tmp/preseed.txt; \
	debconf-set-selections /tmp/preseed.txt && \
	apt update && apt install -y build-essential git wget default-jre openjdk-8-jdk

RUN wget https://github.com/marbl/canu/releases/download/v2.1.1/canu-2.1.1.Linux-amd64.tar.xz && \
	tar xJf canu-2.1.1.Linux-amd64.tar.xz

#RUN git clone https://github.com/marbl/canu.git && \
#	cd canu && \
#	git reset --hard db0a8dac0aa85f14eca41eaa987d6d44a5672a8b && \
#	cd src && \
#	make -j 2

ENV PATH="${PATH}:/usr/src/canu-2.1.1/bin"

#add user (not really necessary)
RUN adduser --disabled-password --gecos '' canuuser
USER canuuser

WORKDIR /home/canuuser

