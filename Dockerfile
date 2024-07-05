FROM ruby:3.3.3

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

WORKDIR /rails

COPY Gemfile /rails/Gemfile

COPY Gemfile.lock /rails/Gemfile.lock

RUN bundle install

COPY . .

EXPOSE 3000

# CMD ["rm", "-f", "tmp/pids/server.pid", "&&", "rails", "server", "-b", "0.0.0.0"]
CMD rm -f tmp/pids/server.pid && rails server -b 0.0.0.0