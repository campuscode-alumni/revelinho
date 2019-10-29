FROM ruby:2.6.4
MAINTAINER Henrique Morato <contato@henriquemorato.com.br>

ENV NODE_VERSION 12
RUN curl -sL https://deb.nodesource.com/setup_$NODE_VERSION.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee \
  /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq

RUN apt-get install -y --no-install-recommends nodejs postgresql-client \
  yarn

RUN mkdir -p /revelinho
WORKDIR /revelinho
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN gem install bundler
RUN bundle install
RUN yarn install --check-files
RUN gem install bundler-audit

COPY . /revelinho
