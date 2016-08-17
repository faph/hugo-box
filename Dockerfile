FROM debian:stable
MAINTAINER Florenz A. P. Hollebrandse
LABEL description="Build and deploy Hugo static websites" \
      version="0.16"

ENV HUGO_URL "https://github.com/spf13/hugo/releases/download/v0.16/hugo_0.16-1_amd64.deb"

RUN apt-get --assume-yes --quiet update \
  && apt-get install --assume-yes --quiet --no-install-recommends \
    git \
    openssh-client \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

ADD $HUGO_URL hugo.deb
RUN dpkg --install hugo.deb \
  && rm hugo.deb
