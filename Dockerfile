FROM ruby:2.5

ENV APP_ROOT /app

WORKDIR $APP_ROOT

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN bundle install -j4

COPY . $APP_ROOT
CMD ["tail", "-f", "/dev/null"]
