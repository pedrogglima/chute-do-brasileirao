FROM ruby:2.6

LABEL maintainer="pedrogglima"

# Allow apt to work with https-based sources
RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
  apt-transport-https build-essential

# Ensure we install an up-to-date version of Node
# See https://github.com/yarnpkg/yarn/issues/2888
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -

# Ensure latest packages for Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | \
  tee /etc/apt/sources.list.d/yarn.list

# Install packages 
RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
  nodejs \
  yarn

ENV RAILS_ENV=production
ENV NODE_ENV=production

COPY Gemfile* /var/www/app/

WORKDIR /var/www/app

# cache installed gems on volume gems
ENV BUNDLE_PATH /gems

RUN bundle install

COPY . /var/www/app/

####### ATENTION #######
# These two commands must be runned by hand before creating this image
#  - bin/rails RAILS_ENV=production assets:clobber
#  - bin/rails RAILS_ENV=production assets:precompile
# It must be runned on production so webpack can extract css, otherwise webpack will raise errors about manifest.json not finding certains files
########################

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
