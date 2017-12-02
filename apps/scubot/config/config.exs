use Mix.Config

config :scubot, ecto_repos: [Scubot.Repo]

import_config "#{Mix.env}.exs"
