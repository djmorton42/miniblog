FROM ruby:2.3.1-slim

RUN apt-get update && apt-get install -qq -y build-essential nodejs libpq-dev postgresql-client-9.4 nginx --fix-missing --no-install-recommends

ENV APP_DIR /opt/miniblog
RUN mkdir -p $APP_DIR/public

WORKDIR $APP_DIR

COPY Gemfile Gemfile
RUN gem install bundler
RUN bundle install

ENV RAILS_ENV production
ENV WORKER_PROCESSES 4
ENV LISTEN_ON 0.0.0.0:8080

RUN rm -rf /etc/nginx/sites-available/default
COPY container/nginx.conf /etc/nginx/sites-available/miniblog.conf
RUN ln -s /etc/nginx/sites-available/miniblog.conf /etc/nginx/sites-enabled

COPY . .

RUN bundle exec rake assets:precompile

VOLUME ["/opt/miniblog/public"]
VOLUME ["/opt/miniblog/tmp"]
VOLUME ["/opt/miniblog/log"]

EXPOSE 80

CMD ["foreman", "start"]
