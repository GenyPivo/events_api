FROM cloudgear/ruby:2.2

RUN apt-get update -qq && apt-get install -y \
                   imagemagick

RUN apt-get autoremove -yq \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /app
WORKDIR /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
ADD . /app
RUN gem install bundler && bundle install
