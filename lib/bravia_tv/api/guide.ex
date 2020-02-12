defmodule BraviaTV.API.Guide do
  @moduledoc """
  Bravia TV API Guide Commands
  """

  alias BraviaTV.API

  ## API

  @doc """
  This API provides the supported services and their information.
  """
  def supported_api_info(),
    do: API.services() |> supported_api_info()

  def supported_api_info(services) do
    "getSupportedApiInfo"
    |> command([%{services: services}])
  end

  ## Private

  def command(method, params \\ [], version \\ "1.0") do
    API.command("guide", method, params, version)
    |> API.parse()
  end
end
