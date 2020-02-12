defmodule BraviaTV.API.Audio do
  @moduledoc """
  Bravia TV API Audio Commands
  """

  alias BraviaTV.API

  # require Logger

  ## API

  @doc """
  This API provides the current settings and supported settings related to the
  sound configuration items.
  """
  def get_sound_settings(target \\ "") do
    "getSoundSettings"
    |> command([%{target: target}], "1.1")
  end

  @doc """
  This API provides the current settings and supported settings related to the
  speaker configuration items.
  """
  def get_speaker_settings() do
    "getSpeakerSettings"
    |> command([%{target: ""}], "1.0")
  end

  @doc """
  This API provides information about the sound volume (and mute status) of
  the device.
  """
  def get_volume_information(),
    do: "getVolumeInformation" |> command()

  @doc """
  This API provides the function to change the audio mute status.
  """
  def set_audio_mute("1.0"), do: :unimplemented

  @doc """
  This API provides the function to change the audio volume level.
  """
  def set_audio_volume("1.0"), do: :unimplemented

  @doc """
  This API provides the function to change the audio volume level.
  """
  def set_audio_volume(volume, target \\ "speaker", ui \\ "on") do
    volume = volume |> to_string()

    "setAudioVolume"
    |> command([%{target: target, volume: volume, ui: ui}], "1.2")
  end

  @doc """
  This API provides the function to change the settings related to sound
  setting items.
  """
  @spec set_sound_settings(String.t()) :: term
  def set_sound_settings(target \\ "") do
    "setSoundSettings"
    |> command([%{target: target}], "1.1")
  end

  @doc """
  This API provides the function to change the settings related to speaker
  setting items.
  """
  def set_speaker_settings() do
    "setSpeakerSettings"
    |> command([
      %{
        settings: [
          %{target: "subwooferPower", value: "off"}
        ]
      }
    ])
  end

  ## Private

  def command(method, params \\ [], version \\ "1.0") do
    API.command("audio", method, params, version)
  end

  # def parse(result, "getVolumeInformation") do
  # end

  # def parse(result, method) do
  #   Logger.debug(fn -> "No parser for #{method}." end)
  #   result
  # end
end
