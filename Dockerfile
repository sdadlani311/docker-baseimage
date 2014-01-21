FROM ubuntu:12.04
MAINTAINER Shiv Dadlani <shiv.dadlani@gmail.com>

ENV HOME /root
RUN mkdir /build
ADD . /build

RUN /build/prepare.sh && \
	/build/system_services.sh && \
	/build/utilities.sh && \
	/build/cleanup.sh

EXPOSE 22 80 443
CMD ["/usr/bin/supervisord"]
