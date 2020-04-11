defmodule HelloWeb.QueueController do
  use HelloWeb, :controller

  def add_song(conn, _params) do
    text(conn, "add ok")
  end

  def mark_played(conn, _params) do
    text(conn, "mark played ok")
  end

  def change_pos(conn, _params) do
    text(conn, "change pos ok")
  end

  def delete_song(conn, _params) do
    text(conn, "delete ok")
  end

  def next(conn, _params) do
    text(conn, "next ok")
  end

end