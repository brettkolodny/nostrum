defmodule Nostrum.Struct.Event.GuildScheduledEventUserAdd do
  @moduledoc """
  Struct representing a guild scheduled event user add event.
  """

  alias Nostrum.Struct.{Guild, User}
  alias Nostrum.Struct.Guild.ScheduledEvent

  defstruct [
    :guild_scheduled_event_id,
    :user_id,
    :guild_id
  ]

  @typedoc """
  The id of the guild the event is scheduled for.
  """
  @type guild_id :: Guild.id()

  @typedoc """
  The id of the user that subscribed to the scheduled event.
  """
  @type user_id :: User.id()

  @typedoc """
  The id of the scheduled event.
  """
  @type guild_scheduled_event_id :: ScheduledEvent.id()

  @type t :: %__MODULE__{
          guild_scheduled_event_id: guild_scheduled_event_id,
          user_id: user_id,
          guild_id: guild_id
        }

  @doc false
  def to_struct(map), do: struct(__MODULE__, map)
end
