FROM elixir:1.14.3

COPY mix.exs mix.exs
COPY mix.lock mix.lock
COPY lib lib
COPY assets assets
COPY config config
COPY priv priv

# https://elixirforum.com/t/elixir-docker-image-wont-build-for-linux-arm64-v8-using-github-actions/56383/12
ENV ERL_FLAGS="+JPperf true"

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get
RUN mix deps.compile

EXPOSE 4000

COPY --chmod=0755 start.sh start.sh
ENTRYPOINT [ "./start.sh" ]
