defmodule Judge.SubmissionEvaluatedListener do
  use GenServer
  require Logger
  alias Judge.Rabbit

  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, name: :submission_evaluated_listener)
  end

  def handle_info({:basic_deliver, json, meta} = event, state) do
    Logger.debug("Received event: #{inspect(event)}")

    {:ok, payload} = Jason.decode(json, keys: :atoms)
    {:ok, changeset} = Judge.TaskJudge.evaluate_submission(payload)

    # :ok = Rabbit.ack(meta.delivery_tag)
    # Logger.debug("Ack'd event: #{inspect(event)}")
    {:noreply, state}
  end

  def handle_info(msg, state) do
    Logger.warn("Received unknown msg #{inspect(msg)}")
    {:noreply, state}
  end

  def handle_call(:pid, _from, state) do
    {:reply, self(), state}
  end

  def get_pid() do
    GenServer.call(:submission_evaluated_listener, :pid)
  end
end
