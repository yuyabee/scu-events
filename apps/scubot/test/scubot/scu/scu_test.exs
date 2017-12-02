defmodule Scubot.SCUTest do
  use Scubot.DataCase

  alias Scubot.SCU

  describe "events" do
    alias Scubot.SCU.Event

    @valid_attrs %{description: "some description", end_time: ~N[2010-04-17 14:00:00.000000], start_time: ~N[2010-04-17 14:00:00.000000], title: "some title", url: "some url"}
    @update_attrs %{description: "some updated description", end_time: ~N[2011-05-18 15:01:01.000000], start_time: ~N[2011-05-18 15:01:01.000000], title: "some updated title", url: "some updated url"}
    @invalid_attrs %{description: nil, end_time: nil, start_time: nil, title: nil, url: nil}

    def event_fixture(attrs \\ %{}) do
      {:ok, event} =
        attrs
        |> Enum.into(@valid_attrs)
        |> SCU.create_event()

      event
    end

    test "list_events/0 returns all events" do
      event = event_fixture()
      assert SCU.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert SCU.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      assert {:ok, %Event{} = event} = SCU.create_event(@valid_attrs)
      assert event.description == "some description"
      assert event.end_time == ~N[2010-04-17 14:00:00.000000]
      assert event.start_time == ~N[2010-04-17 14:00:00.000000]
      assert event.title == "some title"
      assert event.url == "some url"
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = SCU.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      assert {:ok, event} = SCU.update_event(event, @update_attrs)
      assert %Event{} = event
      assert event.description == "some updated description"
      assert event.end_time == ~N[2011-05-18 15:01:01.000000]
      assert event.start_time == ~N[2011-05-18 15:01:01.000000]
      assert event.title == "some updated title"
      assert event.url == "some updated url"
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = SCU.update_event(event, @invalid_attrs)
      assert event == SCU.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = SCU.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> SCU.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = SCU.change_event(event)
    end
  end
end
