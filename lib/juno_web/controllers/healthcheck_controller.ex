defmodule JunoWeb.HealthcheckController do
  @moduledoc false

  @verification """
  I stand atop a spiral stair
  An oracle confronts me there
  He leads me on, light years away
  Through astral nights, galactic days

  I see the works of gifted hands
  That grace this strange and wondrous land
  I see the hand of man arise
  With hungry mind and open eyes
  """

  use JunoWeb, :controller

  def index(conn, _params) do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, @verification)
  end
end
