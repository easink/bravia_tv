# BraviaTV

Simple Bravia TV library.

## Installation

The package can be installed by adding `bravia_tv` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:bravia_tv, github: "easink/bravia_tv"}
  ]
end
```

## Usage

Connect to TV with psk, then use API stuff.

```elixir
BraviaTV.start_link("192.168.1.1", "secret")

BraviaTV.API.Audio.get_volume_information()
{:ok,
 [
   %{
     "maxVolume" => 100,
     "minVolume" => 0,
     "mute" => false,
     "target" => "speaker",
     "volume" => 16
   }
 ]}

BraviaTV.API.Audio.set_audio_volume 16
:ok

```


