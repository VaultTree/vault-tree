FROM alpine:3.4

RUN apk update && apk --update add ruby ruby-irb ruby-json ruby-rake \
    ruby-bigdecimal ruby-io-console libstdc++ tzdata

RUN apk --update add --virtual build_deps \
    build-base ruby-dev libc-dev linux-headers \
    openssl-dev libxml2-dev libxslt-dev libffi-dev

RUN apk --update add --virtual build-dependencies build-base ruby-dev openssl-dev \
    libc-dev linux-headers && \
    gem install bundler --no-rdoc --no-ri

# create the working dir
RUN mkdir /vault-tree

# Set the working dir
WORKDIR /vault-tree

# Add project to working directory
ADD ./ /vault-tree

# bundle gem
RUN bundle install

# cleanup
RUN apk del build_deps

# run all tests
RUN bundle exec rake
