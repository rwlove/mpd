FROM ubuntu:16.04

MAINTAINER “Robert Love” <terp4life2001@gmail.com>

#####
# Configure Environment Variables
#####

# # Ensure UTF-8 lang and locale
RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8
ENV TZ         America/Los_Angeles

ENV DEBIAN_FRONTEND noninteractive

#####
# Configure APT Cacher Proxy
#####

#RUN  echo 'Acquire::http { Proxy "http://apt-cache-proxy:3142"; };' >> /etc/apt/apt.conf.d/01proxy


#####
# Update and Install Packages
#####

RUN apt-get -y update && \
apt-get -y dist-upgrade

RUN apt-get install -y software-properties-common

RUN add-apt-repository -y multiverse

RUN apt-get install -y --allow-unauthenticated \
mpd \
mplayer \
pulseaudio

ADD config/mpd.conf /etc/mpd.conf
COPY scripts/mpd_entrypoint.sh /usr/local/bin/mpd_entrypoint.sh

RUN mkdir -p /run/mpd/

EXPOSE 6600 8000

CMD ["/usr/local/bin/mpd_entrypoint.sh"]

#####
# Clean up
#####

RUN apt-get -y clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*