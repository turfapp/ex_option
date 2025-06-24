FROM elixir:1.18

ENV MIX_ENV=dev \
    LANG=C.UTF-8

RUN apt-get update && \
    apt-get install --yes --no-install-recommends \
        bash \
        build-essential \
        curl \
        git \
        postgresql-client \
        python3 \
        python3-pip \
        inotify-tools \
        neovim && \
    rm -rf /var/lib/apt/lists/*

RUN mix local.hex --force
RUN mix local.rebar --force

# Install Dialyxir globally
RUN mix archive.install hex dialyxir 1.4.5 --force

# Install core PLTs
RUN mix dialyzer --plt

ENV DEBIAN_FRONTEND=dialog
