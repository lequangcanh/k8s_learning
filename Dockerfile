FROM ruby:2.6.5

RUN apt-get update && apt-get install -y build-essential curl cron logrotate gettext-base nano
RUN apt-get clean

# Install yarn because Rails 6 is required
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn

RUN gem install bundler -v 2.0.2

ENV APP_DIR /myapp
RUN mkdir -p $APP_DIR
WORKDIR $APP_DIR

COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
COPY . /myapp
RUN yarn install

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
