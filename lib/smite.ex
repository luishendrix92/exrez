defmodule Exrez.Smite do
  import Exrez, only: [api_call: 2, api_call: 3]

  def god_leaderboard(platform, god_id, queue_id) do
    api_call(platform, "getgodleaderboard", "/#{god_id}/#{queue_id}")
  end

  def god_recommended_items(platform, god_id, language \\ 1) do
    api_call(platform, "getgodrecommendeditems", "/#{god_id}/#{language}")
  end

  def motd(platform), do: api_call(platform, "getmotd")

  def top_matches(platform), do: api_call(platform, "gettopmatches")
end
