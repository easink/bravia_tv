defmodule BraviaTV.API.AVContent do
  @moduledoc """
  Bravia TV Commands
  """

  # require Logger
  alias BraviaTV.API

  ## API

  @doc """
  This API provides the count of contents in the source.
  """
  def get_content_count("1.0"), do: :unimplemented

  @doc """
  This API provides the count of contents in the source.
  """
  def get_content_count("1.1"), do: :unimplemented

  @doc """
  This API provides the list of contents under the URI
  """
  def get_content_list(uri \\ "extInput:hdmi") do
    "getContentList"
    |> command([%{stIdx: 0, cnt: 50, uri: uri}], "1.5")
  end

  # @doc """
  # This API provides information on the current status of all external input sources of the device.
  # """
  # def get_current_external_inputs_status("1.0"), do: :unimplemented

  @doc """
  This API provides the list of schemes that the device can handle.
  """
  def get_scheme_list(),
    do: "getSchemeList" |> command()

  @doc """
  This API provides the list of sources in the scheme.
  """
  def get_source_list(scheme \\ "extInput") do
    "getSourceList"
    |> command([%{scheme: scheme}])
  end

  @doc """
  This API provides information on the current status of all external input sources of the device.
  """
  def get_current_external_inputs_status(),
    do: "getCurrentExternalInputsStatus" |> command()

  @doc """
  This API provides information of the currently playing content or the currently selected input.
  """
  def get_playing_content_info(),
    do: "getPlayingContentInfo" |> command()

  @doc """
  This API provides the function to play content.
  """
  def set_play_content("1.0"), do: :unimplemented

  ## Private

  def command(method, params \\ [], version \\ "1.0") do
    API.command("avContent", method, params, version)
    |> API.parse()
  end
end
