defmodule ViralSpiral.Room.EngineConfig do
  @moduledoc """
  Global configuration for the game engine.

  Unlike its room specific counterpart `ViralSpiral.Entity.Room`, this configuration is global to every game room created on this server. These configuration are loaded at compile time and don't change throughout the runtime of the engine.

  An imagined usecase of this module is to support spinning up varied instances of viral spiral with different characteristics. For instance,
  - Spinning up a server where only communities from :yellow and :red are available for gameplay.
  - Configuring the game engine for quick games by increasing the volatility of the card drawing function
  - Configuring the game engine for collecting granular data on the gameplay for possible research purposes.
  """
  alias ViralSpiral.Bias
  alias ViralSpiral.Affinity
  alias ViralSpiral.Room.EngineConfig

  @type volatility :: :low | :medium | :high
  @type t :: %__MODULE__{
          affinities: list(Affinity.target()),
          communities: list(Bias.target()),
          chaos_counter: integer(),
          volatility: volatility()
        }

  defstruct affinities: Application.compile_env(:viral_spiral, EngineConfig)[:affinities],
            communities: Application.compile_env(:viral_spiral, EngineConfig)[:communities],
            chaos_counter: Application.compile_env(:viral_spiral, EngineConfig)[:chaos_counter],
            volatility: Application.compile_env(:viral_spiral, EngineConfig)[:volatility],
            cancel_threshold:
              Application.compile_env(:viral_spiral, EngineConfig)[:cancel_threshold],
            turn_fake_threshold:
              Application.compile_env(:viral_spiral, EngineConfig)[:turn_fake_threshold],
            viral_spiral_threshold:
              Application.compile_env(:viral_spiral, EngineConfig)[:viral_spiral_threshold]
end

defmodule ViralSpiral.Room.EngineConfig.Guards do
  alias ViralSpiral.Room.EngineConfig
  @affinities Application.compile_env(:viral_spiral, EngineConfig)[:affinities]
  @communities Application.compile_env(:viral_spiral, EngineConfig)[:communities]

  defguard is_affinity(value) when value in @affinities

  defguard is_community(value) when value in @communities
end
