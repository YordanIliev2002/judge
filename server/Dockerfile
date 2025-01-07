FROM elixir:1.14.3

COPY mix.exs mix.exs
COPY mix.lock mix.lock
COPY lib lib
COPY assets assets
COPY config config
COPY priv priv

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get
RUN mix deps.compile

EXPOSE 4000

COPY --chmod=0755 start.sh start.sh
ENTRYPOINT [ "./start.sh" ]
