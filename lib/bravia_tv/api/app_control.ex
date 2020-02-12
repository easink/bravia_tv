defmodule BraviaTV.API.AppControl do
  @moduledoc """
  Bravia TV Commands
  """

  # require Logger
  alias BraviaTV.API

  ## API

  @doc """
  This API provides the list of applications that can be launched bysetActiveApp
  """
  def get_application_list("1.0"),
    do: "getApplicationList" |> command()

  @doc """
  This API provides the status of the application itself or the accompanying
  status related to a specific application.
  """
  def get_application_status_list(),
    do: "getApplicationStatusList" |> command()

  @doc """
  This API returns the current text input on the field of the software
  keyboard.
  """
  def get_text_form("1.1"), do: :unimplemented

  @doc """
  This API provides the functions to retrieve the status of WebAppRuntime and
  to retrieve the URL of the current webpage to open on WebApp.
  """
  def get_web_app_status(),
    do: "getWebAppStatus" |> command()

  @doc """
  This API provides the function to launch applications.
  """
  def set_active_app("1.0"), do: :unimplemented

  @doc """
  This API provides the function to input text on the field of the software
  keyboard.
  """
  def set_text_form("1.0"), do: :unimplemented

  @doc """
  This API provides the function to input text on the field of the software
  keyboard.
  """
  def set_text_form("1.1"), do: :unimplemented

  @doc """
  This API provides the function to terminate all applications.
  """
  def terminate_apps("1.0"), do: :unimplemented

  ## Private

  def command(method, params \\ []) do
    API.command("appControl", method, params)
    |> API.parse()
  end
end
