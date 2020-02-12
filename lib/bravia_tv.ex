defmodule BraviaTV do
  @moduledoc """
  Documentation for BraviaTV.
  """

  def start_link(host, psk \\ nil),
    do: BraviaTV.API.start_link(host, psk)
end
