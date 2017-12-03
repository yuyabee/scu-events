defmodule ScubotWeb.EventController do
  use ScubotWeb, :controller

  alias Scubot.SCU
  alias Scubot.SCU.Event

  action_fallback ScubotWeb.FallbackController

  def index(conn, _params) do
    events = SCU.list_events()
    render(conn, "index.json", events: events)
  end
end
