defmodule Scubot.Repo.Migrations.AddTimePostfixToEvents do
  use Ecto.Migration

  def change do
    alter table(:events) do
      add :time_postfix, :string
    end
  end
end
