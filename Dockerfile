FROM ruby:alpine

RUN apk add --no-cache bash tzdata libxml2-dev libxslt-dev sqlite sqlite-dev nodejs

WORKDIR /temple

COPY Gemfile .

RUN set -ex \
 && apk add --no-cache --virtual .build-dep build-base \
 && gem install nokogiri \
   -- --use-system-libraries \
   --with-xml2-config=/usr/bin/xml2-config \
   --with-xslt-config=/usr/bin/xslt-config \
 && bundle install \
 && apk del .build-dep
