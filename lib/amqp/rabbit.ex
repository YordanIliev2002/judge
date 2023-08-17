defmodule Judge.Rabbit do
  use GenServer
  require Logger

  alias Amqp.Dto.SubmissionAdded

  def send_for_evaluation(submission, task) do
    payload = SubmissionAdded.from(submission, task)
    json_payload = Jason.encode!(payload)
    publish("new-submissions-topic", json_payload)
  end

  defp publish(topic, payload) do
    GenServer.cast(:rabbit, {:send, topic, payload})
  end

  #Genserver stuff
  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, name: :rabbit)
  end

  def init(:ok) do
    config = Application.get_env(:judge, Rabbit)
    {:ok, connection} = AMQP.Connection.open(
      username: config[:username],
      password: config[:password]
    )
    {:ok, channel} = AMQP.Channel.open(connection)
    {:ok, %{channel: channel, connection: connection}}
  end

  def handle_cast({:send, topic, payload}, state) do
    Logger.debug("Sending message #{payload} to topic #{topic}")
    AMQP.Basic.publish(state.channel, topic, "", payload)
    {:noreply, state}
  end

  def terminate(_, state) do
    AMQP.Connection.close(state.connection)
  end
end
