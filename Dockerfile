# syntax = docker/dockerfile:1

# ===========================================================
# BASE STAGE
# ===========================================================
ARG RUBY_VERSION=3.0.6
FROM ruby:${RUBY_VERSION}-slim AS base

WORKDIR /rails

ENV RAILS_ENV=production \
    BUNDLE_DEPLOYMENT=true \
    BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_WITHOUT="development test" \
    RAILS_LOG_TO_STDOUT=true \
    RAILS_SERVE_STATIC_FILES=true \
    LANG=C.UTF-8 \
    DEBIAN_FRONTEND=noninteractive

# ===========================================================
# BUILD STAGE
# ===========================================================
FROM base AS build

# Instala dependências necessárias para compilação de gems
RUN apt-get update -y && \
    apt-get install --no-install-recommends -y \
      build-essential \
      git \
      libpq-dev \
      libvips \
      pkg-config \
      curl && \
    rm -rf /var/lib/apt/lists/*

# Instala Bundler compatível com Ruby 3.0.x
RUN gem uninstall -aIx bundler || true && \
    gem install bundler:2.4.22 && \
    bundle config set --global frozen 'false'

# Copia arquivos de dependência
COPY Gemfile Gemfile.lock ./

# Instala gems
RUN bundle install --jobs 4 --retry 3 && \
    rm -rf ~/.bundle "${BUNDLE_PATH}"/ruby/*/cache

# Copia o restante da aplicação
COPY . .

# Não precisa precompilar assets (API pura)
RUN if [ -f bin/rails ]; then echo "✅ Rails detectado"; else echo "⚠️ bin/rails ausente"; fi

# ===========================================================
# RUNTIME STAGE
# ===========================================================
FROM base

# Instala libs necessárias apenas para runtime
RUN apt-get update -y && \
    apt-get install --no-install-recommends -y \
      libpq-dev \
      libvips \
      curl && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

# Copia gems e código do estágio anterior
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

# Cria usuário não-root e define permissões
RUN useradd rails --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp
USER rails:rails

EXPOSE 3000

# ===========================================================
# ENTRYPOINT + STARTUP LOGIC
# ===========================================================
CMD bash -c "\
  rm -f tmp/pids/server.pid && \
  echo '➡️ Executando migrações...' && \
  bundle exec rails db:migrate && \
  echo '🚀 Iniciando servidor Puma...' && \
  bundle exec rails s -b 0.0.0.0 -e production \
"
