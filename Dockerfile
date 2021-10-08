FROM ruby:3.0

EXPOSE 3000

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . ./

CMD ["./docker/run.sh"]
