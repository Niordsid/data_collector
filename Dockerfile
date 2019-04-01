FROM ruby:2.5

RUN sed -i '/jessie-updates/d' /etc/apt/sources.list 
RUN apt-get update
RUN apt-get install -y locales locales-all
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs imagemagick xmlsec1 postgresql-client
RUN mkdir /data_collector
WORKDIR /data_collector
COPY Gemfile /data_collector/Gemfile
COPY Gemfile.lock /data_collector/Gemfile.lock
RUN bundle install
COPY . /data_collector
