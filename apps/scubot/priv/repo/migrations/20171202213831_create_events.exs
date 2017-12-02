defmodule Scubot.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :title, :string
      add :description, :text
      add :url, :string
      add :start_time, :naive_datetime
      add :end_time, :naive_datetime

      timestamps()
    end

  end
end
