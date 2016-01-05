FROM phusion/passenger-ruby22

# Set the working dir
WORKDIR /home/vault-tree

# Add project to home directory
ADD ./ /home/vault-tree

# bundle gem
RUN bundle install

# run all tests
RUN bundle exec rake
