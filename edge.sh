#!/bin/bash

# Does the user want the latest version
if [ -z "$EDGE" ]; then
  echo "Bleeding edge not requested"
else
  apt-get install -qy git
  mv /opt/PlexConnect/assets/certificates/trailers* /tmp/
  rm -rf /opt/PlexConnect
  git clone https://github.com/iBaa/PlexConnect.git /opt/PlexConnect
  mv /tmp/trailers* /opt/PlexConnect/assets/certificates/
fi

# Generate SSL certificates if they don't exist
if [ -f /opt/PlexConnect/assets/certificates/trailers.pem ] ; then
  echo "SSL certs exist"
else
  openssl req -new -nodes -newkey rsa:2048 \
              -out /opt/PlexConnect/assets/certificates/trailers.pem \
              -keyout /opt/PlexConnect/assets/certificates/trailers.key \
              -x509 -days 7300 -subj "/C=US/CN=trailers.apple.com"
  openssl x509 -in /opt/PlexConnect/assets/certificates/trailers.pem \
               -outform der -out /opt/PlexConnect/assets/certificates/trailers.cer \
               && cat /opt/PlexConnect/assets/certificates/trailers.key >> /opt/PlexConnect/assets/certificates/trailers.pem
fi
