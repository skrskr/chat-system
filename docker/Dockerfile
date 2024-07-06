FROM ruby:3.3.3

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

WORKDIR /rails

COPY ./docker/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

COPY Gemfile /rails/Gemfile

COPY Gemfile.lock /rails/Gemfile.lock

RUN bundle install

COPY . .

EXPOSE 3000

ENTRYPOINT ["entrypoint.sh"]
CMD ["rails", "server", "-b", "0.0.0.0"]