defmodule Exrez.Realm do
  import Exrez, only: [api_call: 3]

  def leaderboard(platform, queue_id, criteria) do
    api_call(platform, "getleaderboard", "/#{queue_id}/#{criteria}")
  end

  def match_history(platform, player_id) do
    api_call(platform, "getplayermatchhistory", "/#{player_id}")
  end

  def player(platform, player, account_origin \\ "hirez") do
    api_call(platform, "getplayer", "/#{player}/#{account_origin}")
  end

  def match_history_after(platform, player_id, date) do
    api_call(platform, "getplayermatchhistoryafterdatetime", "/#{player_id}/#{date}")
  end

  def player_stats(platform, player) do
    api_call(platform, "getplayerstats", "/#{player}")
  end

  def search_players(platform, query) do
    api_call(platform, "searchplayers", "/#{query}")
  end
end
