FROM ubuntu:bionic

# Based on the Dockerfile for moul/icecast by Manfred Touron <m@42.am>
# With the modification by Stéphane Lepin <stephane.lepin@gmail.com>
MAINTAINER Franco Solerio <franco@solerio.net>

ENV DEBIAN_FRONTEND noninteractive
ENV IC_VERSION "2.4.0-kh12"

RUN apt-get -qq -y update && \
	apt-get -qq -y install build-essential \
		wget curl libxml2-dev libxslt1-dev \
		libssl-dev libcurl4-openssl-dev \
		libogg-dev libvorbis-dev libtheora-dev \
		libspeex-dev && \
	wget "https://github.com/karlheyes/icecast-kh/archive/icecast-$IC_VERSION.tar.gz" -O- | tar zxvf - && \
	cd "icecast-kh-icecast-$IC_VERSION" && \
	./configure --with-curl --with-openssl --prefix=/usr --sysconfdir=/etc --localstatedir=/var && \
	make && make install && useradd icecast && \
	chown -R icecast /etc/icecast.xml

ADD ./start.sh /start.sh
ADD ./etc /etc

CMD ["/start.sh"]
EXPOSE 8000
EXPOSE 8001
VOLUME ["/config", "/var/log/icecast"]
