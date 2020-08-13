FROM adoptopenjdk/openjdk8
LABEL maintainer="dev@mesilat.com"

ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

RUN apt-get -y update \
  && apt-get -y install apt-transport-https

ENV SDK_VERSION=8.0.16
RUN echo "deb https://packages.atlassian.com/debian/atlassian-sdk-deb/ stable contrib" >>/etc/apt/sources.list \
    && apt-get -y install gnupg2 \
    && curl https://packages.atlassian.com/api/gpg/key/public -o /tmp/public \
    && apt-key add /tmp/public \
    && apt-get -y update \
    && apt-get -y install atlassian-plugin-sdk=${SDK_VERSION}

RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" >>/etc/apt/sources.list \
    && curl https://dl.yarnpkg.com/debian/pubkey.gpg -o /tmp/public \
    && apt-key add /tmp/public \
    && apt-get -y update \
    && apt-get -y install yarn \
    && yarn --version

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
CMD ["atlas-version"]
