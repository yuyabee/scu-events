defmodule Scubot.Application do
  @moduledoc """
  The Scubot Application Service.

  The scubot system business domain lives in this application.

  Exposes API to clients such as the `ScubotWeb` application
  for use in channels, controllers, and elsewhere.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Supervisor.start_link([
      supervisor(Scubot.Repo, []),
    ], strategy: :one_for_one, name: Scubot.Supervisor)
  end
end
