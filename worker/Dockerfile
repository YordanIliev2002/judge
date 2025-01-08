FROM elixir:1.14.3

COPY mix.exs mix.exs
COPY mix.lock mix.lock
COPY lib lib
COPY config config

# https://elixirforum.com/t/elixir-docker-image-wont-build-for-linux-arm64-v8-using-github-actions/56383/12
ENV ERL_FLAGS="+JPperf true"

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get
RUN mix deps.compile

ENTRYPOINT [ "mix", "run", "--no-halt" ]
