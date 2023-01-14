FROM netsandbox/request-tracker:5.0
MAINTAINER kost 

ENV RTIR_VERSION 5.0.3
# https://download.bestpractical.com/pub/rt/release/RT-IR-5.0.3.tar.gz

#get wget
RUN apt-get update && apt-get install -y wget

RUN  wget -O /tmp/RT-IR-$RTIR_VERSION.tar.gz https://download.bestpractical.com/pub/rt/release/RT-IR-$RTIR_VERSION.tar.gz && \
    tar -xvz -C /tmp -f /tmp/RT-IR-$RTIR_VERSION.tar.gz && \
    cd /tmp/RT-IR-$RTIR_VERSION && \
    cpan -f Parse::BooleanLogic && \
    perl Makefile.PL && \
    make install && \
    cd / && rm -rf RT-IR-$RTIR_VERSION RT-IR-$RTIR_VERSION.tar.gz && \
    echo "Success"


WORKDIR /opt/rt5
COPY RT_SiteConfig.pm etc/

VOLUME /opt/rt5

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 80
CMD ["/opt/rt5/sbin/rt-server"]
