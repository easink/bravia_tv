defmodule BraviaTV.API.Encryption do
  @moduledoc """
  Bravia TV Commands
  """

  # require Logger
  alias BraviaTV.API

  ## API

  @doc """
  This API requests the device to provide an RSA public key for encryption.
  For details on encryption specifications, please see Data Encryption.
  """
  def get_public_key(),
    do: "getPublicKey" |> command()

  ## Private

  def command(method, params \\ []) do
    API.command("encryption", method, params)
    |> API.parse()
  end
end
