# TODO - actually make a production release, instad of starting the app in dev mode
FROM elixir:1.14.3

COPY mix.exs mix.exs
COPY mix.lock mix.lock
COPY lib lib
COPY config config

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get
RUN mix deps.compile

ENTRYPOINT [ "mix", "run", "--no-halt" ]