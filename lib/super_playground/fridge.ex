defmodule SuperPlayground.Fridge do
  use GenServer

  def start_link(initial_state \\ [], options \\ []) do
    GenServer.start_link(__MODULE__, initial_state, options)
  end

  def store(fridge, item) do
    GenServer.call(fridge, {:store, item})
  end

  def take(fridge, item) do
    GenServer.call(fridge, {:take, item})
  end

  # Callbacks

  def init(state) do
    {:ok, state}
  end

  def handle_call({:store, item}, _from, state) do
    {:reply, :ok, [item | state]}
  end
  def handle_call({:take, item}, _from, state) do
    case Enum.member?(state, item) do
      true  -> {:reply, {:ok, item}, List.delete(state, item)}
      false -> {:reply, {:error, :not_found}, state}
    end
  end
end
