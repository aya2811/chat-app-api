FROM ruby:3.1.2
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y build-essential libpq-dev
RUN gem update && gem install rails && gem install bundler

WORKDIR /chat-app

ADD Gemfile /chat-app/Gemfile
ADD Gemfile.lock /chat-app/Gemfile.lock

RUN bundle install 

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]

