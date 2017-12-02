defmodule Scubot.SCU.Client do
  alias HTTPoison.{Response}
  require Logger

  @url "https://lwcal.scu.edu/live/calendar/view/all?user_tz=America/Tijuana&syntax=<widget type=\"events_calendar\"><arg id=\"modular\">true</arg><arg id=\"hide_repeats\">true</arg><arg id=\"exclude_tag\">private</arg><arg id=\"exclude_group\">Math Tutors</arg><arg id=\"mini_cal_heat_map\">true</arg><arg id=\"thumb_width\">200</arg><arg id=\"thumb_height\">200</arg></widget>"

  def get_events do
    with {:ok, %Response{body: body}} <- HTTPoison.get(URI.encode(@url)),
          %{"event_count" => ec, "per_page" => pp} <- body |> Poison.decode! do
      1..(ec / pp |> Float.ceil |> Kernel.trunc) |> Enum.each(fn page ->
        with {:ok, %Response{body: body}} <- HTTPoison.get(URI.encode(@url <> "&page=#{page}")),
              %{"events" => events} <- body |> Poison.decode! do
            events =
              events
              |> Enum.map(&(&1 |> Tuple.to_list |> List.last))
              |> List.flatten
              |> Enum.each(fn event ->
                event |> from_wild |> Scubot.SCU.create_event
              end)
        end
      end)
    end
  end

  def from_wild(%{"title" => title} = event),
    do: from_wild(event |> Map.delete("title"), %{title: title, location: nil, start_time: nil, end_time: nil, description: nil})
  def from_wild(_),
    do: nil

  def from_wild(%{"location" => location} = event, acc),
    do: from_wild(event |> Map.delete("location"), %{acc | location: location})
  def from_wild(%{"ts_start" => start_time} = event, acc),
    do: from_wild(event |> Map.delete("ts_start"), %{acc | start_time: start_time |> DateTime.from_unix!})
  def from_wild(%{"ts_end" => end_time} = event, acc),
    do: from_wild(event |> Map.delete("ts_end"), %{acc | end_time: end_time |> DateTime.from_unix!})
  def from_wild(%{"summary" => description}, acc),
    do: %{acc | description: description}
  def from_wild(_, acc),
    do: acc
end
