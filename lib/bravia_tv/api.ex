defmodule BraviaTV.API do
  @moduledoc """
  Bravia TV API
  """
  use GenServer

  alias BraviaTV.HTTP

  @version "1.0"

  ## Start / Stop

  def start_link(host, psk \\ nil) do
    GenServer.start_link(__MODULE__, {host, psk}, name: __MODULE__)
  end

  def init({host, psk}) do
    HTTP.start()

    {
      :ok,
      %{
        uri: %URI{scheme: "http", host: host},
        psk: psk,
        id: 1
      }
      # continue: :get_supported_api_info
    }
  end

  @spec services() :: list(String.t())
  def services do
    [
      "guide",
      "appControl",
      "audio",
      "avContent",
      "encryption",
      "system",
      "videoScreen"
    ]
  end

  ## API

  def command(service, method, params \\ [], version \\ @version) do
    GenServer.call(__MODULE__, {service, method, params, version})
  end

  def parse(:ok), do: :ok
  def parse({:ok, [result]}), do: {:ok, result}

  ## Callbacks

  # def handle_continue(:get_supported_api_info, _state) do
  # end

  def handle_call({service, method, params, version}, _from, state) do
    path = Path.join("/sony", service)
    uri = %URI{state.uri | path: path}
    data = %{method: method, params: params, id: state.id, version: version}

    reply = request(uri, state.psk, data)

    {:reply, reply, %{state | id: state.id + 1}}
  end

  ## Private

  # @spec request(%URI{}, String.t(), list(map)) :: :ok | {:ok, term} | {:error, term}
  defp request(uri, psk, data) do
    with {:ok, json} <- Jason.encode(data),
         {:ok, response} <- HTTP.post(uri, psk, json),
         {:ok, result} <- decode_response(response, data.id) do
      case result do
        [] -> :ok
        # [result] -> {:ok, result}
        result -> {:ok, result}
      end
    end
  end

  defp decode_response(response, id) do
    case Jason.decode(response) do
      {:ok, %{"result" => result, "id" => ^id}} -> {:ok, result}
      {:ok, %{"result" => _reason, "id" => _id}} -> {:error, :bad_id}
      {:ok, %{"error" => reason}} -> {:error, reason}
      {:error, [_reason_id, reason]} -> {:error, reason}
      {:error, reason} -> {:error, reason}
    end
  end
end
