# base image
FROM ubuntu:latest

# install unix tools
RUN apt-get update && apt-get install -y \
  curl \
  git \
  gcc \
  make \
  openssl \
  tree \
  unzip \
  wget

# install ruby and rails dependencies
RUN apt-get update && apt-get install -y \
  build-essential \
  zlib1g-dev \
  libssl-dev \
  libreadline6-dev \
  libyaml-dev \
  libpq-dev \
  libcurl3 \
  libcurl3-gnutls \
  libcurl4-openssl-dev

# download ruby
RUN curl http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.3.tar.gz > /tmp/ruby-2.1.3.tar.gz

# compile ruby
RUN cd /tmp && \
  tar -xzf ruby-2.1.3.tar.gz && \
  cd ruby-2.1.3 && \
  ./configure && \
  make && \
  make install

# install bundler
RUN gem install bundler

# Set the working dir
WORKDIR /home/vault-tree

# Add project to home directory
ADD ./ /home/vault-tree

# bundle gem
RUN bundle install

# run all tests
RUN rake
