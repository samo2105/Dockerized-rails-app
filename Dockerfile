FROM ruby:2.7

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Install Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main"
RUN tee /etc/apt/sources.list.d/yarn.list
RUN apt update && apt install -y --no-install-recommends yarn

# Copy app files
RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
COPY . /myapp

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]