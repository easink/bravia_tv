defmodule BraviaTV.HTTP do
  @moduledoc """
  Bravia TV HTTP
  """

  @connect_timeout 1_000
  @timeout 10 * 60 * 1_000

  @proxy_env "HTTP_PROXY"

  require Logger

  ## start / stop

  def start() do
    # :inets.start()

    proxy_env = proxy()

    if proxy_env do
      :httpc.set_options([{:proxy, {proxy_env, []}}])
    end
  end

  def stop() do
    :inets.services()
    |> Enum.each(fn {service, pid} ->
      :inets.stop(service, pid)
    end)
  end

  ## API

  @spec post(URI.t(), String.t(), String.t(), Keyword.t()) :: {:ok, binary} | {:error, term}
  def post(%URI{} = uri, psk, data, _opts \\ []) do
    http_options = [
      timeout: @timeout,
      connect_timeout: @connect_timeout
      # ssl: [verify: 0]
    ]

    # :httpc.set_options([{:verbose, :debug}])
    options = [body_format: :binary]

    Logger.debug(fn -> "Post #{uri.path} #{data}..." end)

    url = uri |> URI.to_string() |> to_charlist()

    headers = [] |> maybe_add_header('X-Auth-PSK', psk)

    request = {
      url,
      headers,
      'application/json; charset=UTF-8',
      data
    }

    case :httpc.request(:post, request, http_options, options) do
      {:ok, {{_version, 200, _reason}, _headers, body}} ->
        Logger.debug("Posted, got #{body}")
        {:ok, body}

      {:ok, {{_version, status, _reason}, _headers, _body}} ->
        Logger.error(fn -> "Posting to #{url}, failed with status #{status}" end)
        {:error, :post_failed}

      {:error, reason} ->
        Logger.error(fn -> "Posting error to #{url}: #{inspect(reason)}" end)
        {:error, reason}
    end
  end

  ## Private

  @spec maybe_add_header(list, charlist, String.t() | nil) :: list
  defp maybe_add_header(headers, _header, nil), do: headers

  defp maybe_add_header(headers, header, psk),
    do: [{header, psk |> to_charlist()} | headers]

  @spec proxy() :: nil | tuple()
  defp proxy() do
    case System.get_env(@proxy_env) || System.get_env(@proxy_env |> String.downcase()) do
      nil ->
        nil

      proxy ->
        [_schema, host, port] = proxy |> String.split(":")
        # {(schema <> ":" <> host) |> to_charlist(), port |> String.to_integer()}
        {host |> String.trim_leading("/") |> to_charlist(), port |> String.to_integer()}
    end
  end
end
