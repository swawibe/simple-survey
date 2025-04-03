# syntax = docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.2.0
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base

# Rails app lives here
WORKDIR /rails

# Set production environment
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development test" \
    NODE_ENV="production" \
    SECRET_KEY_BASE_DUMMY="1"

# Install essential dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential git libvips pkg-config curl gnupg2 libsqlite3-0 && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Install Node.js
RUN curl -sL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

FROM base as dependencies

# Copy Gemfile and install gems (this layer is cached if Gemfile doesn't change)
COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git

# Precompile bootsnap cache
RUN bundle exec bootsnap precompile --gemfile

# Build stage: Copy the application
FROM dependencies as build

COPY . .

# Precompile bootsnap code
RUN bundle exec bootsnap precompile app/ lib/

# Precompile assets (if needed)
RUN SECRET_KEY_BASE=$SECRET_KEY_BASE_DUMMY ./bin/rails assets:precompile

# Final stage: Minimal runtime image
FROM base

# Copy built application from previous stages
COPY --from=dependencies /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

# Ensure the storage directory exists (for SQLite & file uploads)
RUN mkdir -p /rails/storage && chown -R 1000:1000 /rails/storage
VOLUME ["/rails/storage"]

# Create a non-root user
RUN useradd -u 1000 -m rails --create-home --shell /bin/bash && \
    chown -R rails:rails db log tmp
USER rails:rails

# Entrypoint script
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Expose port and start the server
EXPOSE 3000
CMD ["./bin/rails", "server"]
