FROM alpine:3.4

RUN apk update && apk --no-cache add curl wget openssl ca-certificates \
    less libstdc++ pcre libffi libxml2 libxslt zlib tzdata ruby ruby-json ruby-rake \
    ruby-bigdecimal ruby-bundler ruby-rdoc ruby-io-console ruby-irb \
    &&  rm -rf /var/cache/apk/*

RUN apk --update add --virtual build_deps \
    build-base ruby-dev libc-dev linux-headers \
    openssl-dev libxml2-dev libxslt-dev libffi-dev

# create the working dir
RUN mkdir /vault-tree

# Set the working dir
WORKDIR /vault-tree

# Add project to working directory
ADD ./ /vault-tree

# bundle gem
RUN bundle install

# run all tests
RUN bundle exec rake
