defmodule Scubot.Repo.Migrations.AddLocationToRemoveUrlFromEvents do
  use Ecto.Migration

  def change do
    alter table(:events) do
      add :location, :string
      remove :url
    end
  end
end
