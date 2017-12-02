defmodule ScubotWeb.PageController do
  use ScubotWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
