FROM        debian
MAINTAINER  Laurie Clark-Michalek <lclarkmichalek@gmail.com>

# Update the package repository and install applications
RUN apt-get update && \
  apt-get upgrade --no-install-recommends -y && \
  apt-get -y install --no-install-recommends varnish && \
  apt-get -y clean

# Expose port 80
EXPOSE 80

ADD start.sh /start.sh
CMD ["/start.sh"]
