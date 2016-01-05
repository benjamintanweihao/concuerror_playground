defmodule Stacky do
  use GenServer
  require Integer

  @name __MODULE__

  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: @name)
  end

  def add(item) do
    GenServer.call(@name, {:add, item})
  end

  def tag(item) do
    GenServer.call(@name, {:tag, item})
  end

  def init(:ok) do
    {:ok, []}
  end

  def handle_call({:add, item}, _from, state) do
    new_state = [item|state]
    {:reply, {:ok, new_state}, new_state} 
  end

  def handle_call({:tag, item}, _from, state) when Integer.is_even(item) do
    add({:even, item})
    # new_state = [{:even, item} |state]
    # {:reply, {:ok, new_state}, new_state} 
  end

  def handle_call({:tag, item}, _from, state) when Integer.is_odd(item) do
    add({:odd, item})
    # new_state = [{:odd, item} |state]
    # {:reply, {:ok, new_state}, new_state} 
  end

end
