FROM ruby:2.6-rc

ENV APP_ROOT /app

WORKDIR $APP_ROOT

RUN apt-get update \
		&& apt-get install -y mecab libmecab-dev mecab-ipadic mecab-ipadic-utf8

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN bundle install -j4

COPY . $APP_ROOT

# CMD ["tail", "-f", "/dev/null"]
# FIXME: 起動時にDBが初期化されてないので死ぬ問題を解決する
CMD ["slappy", "start"]
