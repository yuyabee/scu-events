defmodule Scubot.SCU.Event do
  use Ecto.Schema
  import Ecto.Changeset
  alias Scubot.SCU.Event

  schema "events" do
    field :description, :string
    field :end_time, :naive_datetime
    field :start_time, :naive_datetime
    field :title, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(%Event{} = event, attrs) do
    event
    |> cast(attrs, [:title, :description, :url, :start_time, :end_time])
    |> validate_required([:title])
  end
end
