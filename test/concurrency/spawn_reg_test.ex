Code.require_file "../test_helper.exs", __DIR__

defmodule SpawnReg.ConcurrencyTest do
  import SpawnReg
  
  def test do
    me = self
    spawn(fn -> send(me, start) end)
    send(:name, :stop)

    # The race condition here happens because
    # the process might not complete setting name up yet.
    # Therefore, send/2 might fail if `:name` 
    # is not registered yet
  end

end
