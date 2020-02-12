defmodule BraviaTV.API.System do
  @moduledoc """
  Bravia TV API System Commands
  """

  alias BraviaTV.API

  ## API

  @doc """
  This API provides the current time set in the device.
  """
  def get_current_time() do
    with {:ok, date} <- "getCurrentTime" |> command(),
         do: {:ok, DateTime.from_iso8601(date)}
  end

  # @doc """
  # This API provides the current time set in the device.
  # This version has the additional response parameters of timezone and
  # DST (Daylight Saving Time) offset information.
  # """
  # def get_current_time("1.1"), do: :ignore_use_1_0_instead

  @doc """
  This API provides information of the REST API interface provided by the
  server.
  """
  def get_interface_information(),
    do: "getInterfaceInformation" |> command()

  @doc """
  This API provides the function to get the LED Indicator mode.
  """
  def get_led_indicator_status(),
    do: "getLEDIndicatorStatus" |> command()

  @doc """
  This API provides information about network settings.
  """
  @spec get_network_settings(String.t()) :: {:ok, list(map)} | {:error, term}
  def get_network_settings(interface \\ "") do
    "getNetworkSettings"
    |> command([%{netif: interface}])
  end

  @doc """
  This API provides the setting of the power saving mode to adjust the device’s
  power consumption.
  """
  def get_power_saving_mode(),
    do: "getPowerSavingMode" |> command()

  @doc """
  This API provides the current power status of the device.
  """
  def get_power_status(),
    do: "getPowerStatus" |> command()

  @doc """
  This API provides the information of the device’s remote commander.
  """

  def get_remote_controller_info(),
    do: "getRemoteControllerInfo" |> command_raw()

  @doc """
  This API provides the current settings and supported settings related to the
  remote device, which can access the server device from outside the door.
  """
  def get_remote_device_settings(target \\ "") do
    "getRemoteDeviceSettings"
    |> command([%{target: target}])
  end

  @doc """
  This API provides general information on the device.
  """
  def get_system_information(),
    do: "getSystemInformation" |> command()

  @doc """
  This API provides the list of device capabilities within the scope of system
  service handling.
  """
  def get_system_supported_function(),
    do: "getSystemSupportedFunction" |> command()

  @doc """
  This API provides information on the device’s WoL (Wake-on-LAN) mode
  settings.
  """
  def get_wol_mode(),
    do: "getWolMode" |> command()

  @doc """
  This API provides the function to reboot the device.
  """
  def request_reboot(),
    do: "requestReboot" |> command()

  @doc """
  This API provides the function to light up a specific LED Indicator, usually
  equipped in the front of the device to show the current device status to the
  user.
  """
  def set_led_indicator_status("1.1"), do: :unimplemented

  @doc """
  This API provides the language setting of the device.
  """
  def set_language("1.0"), do: :unimplemented

  @doc """
  This API provides the function to change the setting of the power saving
  mode, and adjust the device’s power consumption.
  """
  def set_power_saving_mode("1.0"), do: :unimplemented

  @doc """
  This API provides the function to change the current power status of the
  device.
  """
  def set_power_status("1.0"), do: :unimplemented

  @doc """
  This API is for changing the WoL (Wake-on-LAN) mode settings of the device.
  """
  def set_wol_mode("1.0"), do: :unimplemented

  ## Private

  def command(method, params \\ [], version \\ "1.0") do
    API.command("system", method, params, version)
    |> API.parse()
  end

  def command_raw(method, params \\ []) do
    API.command("system", method, params)
  end
end
