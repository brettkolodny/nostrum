defmodule Nostrum.Struct.Message do
  @moduledoc """
  A `Nostrum.Struct.Message` represents a message.

  More information can be found on the
  [Discord API Message Object Documentation](https://discord.com/developers/docs/resources/channel#message-object).
  """

  alias Nostrum.Struct.{Channel, Embed, Guild, Interaction, User}
  alias Nostrum.Struct.Guild.{Member, Role}
  alias Nostrum.Struct.Message.{Activity, Application, Attachment, Reaction, Reference, Sticker}
  alias Nostrum.{Snowflake, Util}

  defstruct [
    :activity,
    :application,
    :application_id,
    :attachments,
    :author,
    :channel_id,
    :content,
    :components,
    :edited_timestamp,
    :embeds,
    :id,
    :interaction,
    :guild_id,
    :member,
    :mention_everyone,
    :mention_roles,
    :mention_channels,
    :mentions,
    :message_reference,
    :nonce,
    :pinned,
    :reactions,
    :referenced_message,
    :sticker_items,
    :timestamp,
    :thread,
    :tts,
    :type,
    :webhook_id
  ]

  @typedoc "The id of the message"
  @type id :: Snowflake.t()

  @typedoc "The id of the guild"
  @type guild_id :: Guild.id() | nil

  @typedoc "The id of the channel"
  @type channel_id :: Channel.id()

  @typedoc "The user struct of the author"
  @type author :: User.t()

  @typedoc "The content of the message"
  @type content :: String.t()

  @typedoc "When the message was sent"
  @type timestamp :: String.t()

  @typedoc "When the message was edited"
  @type edited_timestamp :: String.t() | nil

  @typedoc "Whether this was a TTS message"
  @type tts :: boolean

  @typedoc """
  Whether this messsage mentions everyone
  """
  @type mention_everyone :: boolean

  @typedoc """
  List of channels mentioned in the message

  [Discord API Channel Mention Object Documentation](https://discord.com/developers/docs/resources/channel#channel-mention-object-channel-mention-structure)
  """
  @type mention_channels :: [Channel.channel_mention()]

  @typedoc "List of users mentioned in the message"
  @type mentions :: [User.t()]

  @typedoc "List of roles ids mentioned in the message"
  @type mention_roles :: [Role.id()]

  @typedoc "List of attached files in the message"
  @type attachments :: [Attachment.t()]

  @typedoc """
  List of Message Components
  """
  @type components :: [Component.t()]

  @typedoc """
  Array of Message Sticker Item Objects
  """
  @type sticker_items :: [Sticker.t()]

  @typedoc """
  Message interaction object
  """
  @type interaction :: Interaction.t()

  @typedoc "List of embedded content in the message"
  @type embeds :: [Embed.t()]

  @typedoc "Reactions to the message."
  @type reactions :: [Reaction.t()] | nil

  @typedoc "Validates if a message was sent"
  @type nonce :: String.t() | nil

  @typedoc "Whether this message is pinned"
  @type pinned :: boolean

  @typedoc """
  If the message is generated by a webhook, this is the webhook's id
  """
  @type webhook_id :: Snowflake.t() | nil

  @typedoc """
  [Discord API Message Object Type Documentation](https://discord.com/developers/docs/resources/channel#message-object-message-types)

  - `0`  - `DEFAULT`
  - `1`  - `RECIPIENT_ADD`
  - `2`  - `RECIPIENT_REMOVE`
  - `3`  - `CALL`
  - `4`  - `CHANNEL_NAME_CHANGE`
  - `5`  - `CHANNEL_ICON_CHANGE`
  - `6`  - `CHANNEL_PINNED_MESSAGE`
  - `7`  - `GUILD_MEMBER_JOIN`
  - `8`  - `USER_PREMIUM_GUILD_SUBSCRIPTION`
  - `9`  - `USER_PREMIUM_GUILD_SUBSCRIPTION_TIER_1`
  - `10` - `USER_PREMIUM_GUILD_SUBSCRIPTION_TIER_2`
  - `11` - `USER_PREMIUM_GUILD_SUBSCRIPTION_TIER_3`
  - `12` - `CHANNEL_FOLLOW_ADD`
  - `14` - `GUILD_DISCOVERY_DISQUALIFIED`
  - `15` - `GUILD_DISCOVERY_REQUALIFIED`
  - `16` - `GUILD_DISCOVERY_GRACE_PERIOD_INITIAL_WARNING`
  - `17` - `GUILD_DISCOVERY_GRACE_PERIOD_FINAL_WARNING`
  - `18` - `THREAD_CREATED`
  - `19` - `REPLY`
  - `20` - `APPLICATION_COMMAND`
  - `21` - `THREAD_STARTER_MESSAGE`
  - `22` - `GUILD_INVITE_REMINDER`
  """
  @type type :: integer()

  @typedoc """
  The activity of the message. Sent with Rich Presence-related chat embeds
  """
  @type activity :: Activity.t() | nil

  @typedoc """
  The application of the message. Sent with Rich Presence-related chat embeds
  """
  @type application :: Application.t() | nil

  @typedoc """
  if the message is a response to an interaction, this is the ID of the interaction's application
  """
  @type application_id :: Application.id() | nil
  @typedoc """
  Partial Guild Member object received with the Message Create event if message came from a guild channel
  """
  @type member :: Member.t() | nil

  @typedoc """
  Reference data sent with crossposted messages and replies
  """
  @type message_reference :: Reference.t() | nil

  @typedoc """
  The message associated with the `:message_reference`

  This field is only returned for messages with a `type: 19` (Reply). If the message is a reply but the`:referenced_message` field is not present, the backend did not attempt to fetch the message that was being replied to,so its state is unknown. If the field exists but is `nil`, the referenced message was deleted.
  """
  @type referenced_message :: __MODULE__.t() | nil

  @typedoc """
  The thread that was started from this message, includes a thread member object
  """
  @type thread :: Channel.t() | nil

  @type t :: %__MODULE__{
          activity: activity,
          application_id: application_id,
          application: application,
          attachments: attachments,
          author: author,
          channel_id: channel_id,
          components: components,
          content: content,
          edited_timestamp: edited_timestamp,
          embeds: embeds,
          guild_id: guild_id,
          id: id,
          interaction: interaction,
          member: member,
          mention_everyone: mention_everyone,
          mention_roles: mention_roles,
          mentions: mentions,
          message_reference: message_reference,
          nonce: nonce,
          pinned: pinned,
          reactions: reactions,
          referenced_message: referenced_message,
          sticker_items: sticker_items,
          thread: thread,
          timestamp: timestamp,
          tts: tts,
          type: type,
          webhook_id: webhook_id
        }

  @doc false
  def to_struct(map) do
    new =
      map
      |> Map.new(fn {k, v} -> {Util.maybe_to_atom(k), v} end)
      |> Map.update(:activity, nil, &Util.cast(&1, {:struct, Activity}))
      |> Map.update(:application_id, nil, &Util.cast(&1, Snowflake))
      |> Map.update(:application, nil, &Util.cast(&1, {:struct, Application}))
      |> Map.update(:attachments, nil, &Util.cast(&1, {:list, {:struct, Attachment}}))
      |> Map.update(:author, nil, &Util.cast(&1, {:struct, User}))
      |> Map.update(:channel_id, nil, &Util.cast(&1, Snowflake))
      |> Map.update(:components, nil, &Util.cast(&1, {:list, {:struct, Component}}))
      |> Map.update(:embeds, nil, &Util.cast(&1, {:list, {:struct, Embed}}))
      |> Map.update(:guild_id, nil, &Util.cast(&1, Snowflake))
      |> Map.update(:id, nil, &Util.cast(&1, Snowflake))
      |> Map.update(:interaction, nil, &Util.cast(&1, {:struct, Interaction}))
      |> Map.update(:member, nil, &Util.cast(&1, {:struct, Member}))
      |> Map.update(:mention_channels, nil, &Util.cast(&1, {:list, {:struct, Channel}}))
      |> Map.update(:mention_roles, nil, &Util.cast(&1, {:list, Snowflake}))
      |> Map.update(:mentions, nil, &Util.cast(&1, {:list, {:struct, User}}))
      |> Map.update(:message_reference, nil, &Util.cast(&1, {:struct, Reference}))
      |> Map.update(:nonce, nil, &Util.cast(&1, Snowflake))
      |> Map.update(:reactions, nil, &Util.cast(&1, {:list, {:struct, Reaction}}))
      |> Map.update(:referenced_message, nil, &Util.cast(&1, {:struct, __MODULE__}))
      |> Map.update(:sticker_items, nil, &Util.cast(&1, {:list, {:struct, Sticker}}))
      |> Map.update(:thread, nil, &Util.cast(&1, {:struct, Channel}))
      |> Map.update(:webhook_id, nil, &Util.cast(&1, Snowflake))

    struct(__MODULE__, new)
  end

  @doc """
  Takes the message and produces a URL that, when clicked from the user client, will
  jump them to that message, assuming they have access to the message and the message
  is valid.
  """
  @doc since: "0.5.0"
  @spec to_url(Module.t()) :: String.t()
  def to_url(%__MODULE__{} = msg) do
    "https://discord.com/channels/" <>
      (msg.guild_id || "@me") <> "/" <> msg.channel_id <> "/" <> msg.id
  end
end
