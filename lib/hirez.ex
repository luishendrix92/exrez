defmodule Exrez.Hirez do
  import Exrez, only: [api_call: 2, api_call: 3]

  def ping(platform), do: api_call(platform, "ping")

  def test_session(platform), do: api_call(platform, "testsession")

  def server_status(platform) do
    case api_call(platform, "gethirezserverstatus") do
      {:ok, [status]} -> {:ok, status}
      result -> result
    end
  end

  def data_used(platform) do
    case api_call(platform, "getdataused") do
      {:ok, [used]} -> {:ok, used}
      result -> result
    end
  end

  def demo_details(platform, match_id) do
    case api_call(platform, "getdemodetails", "/#{match_id}") do
      {:ok, [details]} -> {:ok, details}
      result -> result
    end
  end

  def pro_league(platform) do
    api_call(platform, "getesportsproleaguedetails")
  end

  def friends(platform, player) do
    case platform do
      :paladins_pc -> api_call(:paladins_pc, "getfriends", "/#{player}")
      :smite_pc -> api_call(:smite_pc, "getfriends", "/#{player}")
      _ -> {:err, "Friend list endpoint is PC-exclusive."}
    end
  end

  def god_ranks(platform, player) do
    api_call(platform, "getgodranks", "/#{player}")
  end

  def gods(platform, language \\ 1) do
    api_call(platform, "getgods", "/#{language}")
  end

  def god_skins(platform, god_id, language \\ 1) do
    api_call(platform, "getgodskins", "/#{god_id}/#{language}")
  end

  def items(platform, language \\ 1) do
    api_call(platform, "getitems", "/#{language}")
  end

  def match_details(platform, match_id) do
    api_call(platform, "getmatchdetails", "/#{match_id}")
  end

  def match_details_batch(platform, match_ids) do
    api_call(platform, "getmatchdetailsbatch", "/#{Enum.join(match_ids, ",")}")
  end

  def match_player_details(platform, match_id) do
    api_call(platform, "getmatchplayerdetails", "/#{match_id}")
  end

  def match_ids_by_queue(platform, queue, date, hour) do
    api_call(platform, "getmatchidsbyqueue", "/#{queue}/#{date}/#{hour}")
  end

  def league_leaderboard(platform, queue, tier, season) do
    api_call(platform, "getleagueleaderboard", "/#{queue}/#{tier}/#{season}")
  end

  def league_seasons(platform, queue) do
    api_call(platform, "getleagueseasons", "/#{queue}")
  end

  def match_history(platform, player) do
    api_call(platform, "getmatchhistory", "/#{player}")
  end

  def player_info_xb_ns(platform, player_name) do
    api_call(platform, "getplayeridinfoforxboxandswitch", "/#{player_name}")
  end

  def player(platform, player) do
    api_call(platform, "getplayer", "/#{player}")
  end

  def player_loadouts(platform, player, language \\ 1) do
    api_call(platform, "getplayerloadouts", "/#{player}/#{language}")
  end

  def player_status(platform, player) do
    case api_call(platform, "getplayerstatus", "/#{player}") do
      {:ok, [status]} -> {:ok, status}
      result -> result
    end
  end

  def queue_stats(platform, player, queue) do
    api_call(platform, "getqueuestats", "/#{player}/#{queue}")
  end

  def team_details(platform, clan_id) do
    api_call(platform, "getteamdetails", "/#{clan_id}")
  end

  def team_players(platform, clan_id) do
    api_call(platform, "getteamplayers", "/#{clan_id}")
  end

  def search_teams(platform, team) do
    api_call(platform, "searchteams", "/#{team}")
  end

  def player_achievements(platform, player_id) do
    api_call(platform, "getplayerachievements", "/#{player_id}")
  end

  def patch_info(platform), do: api_call(platform, "getpatchinfo")
end
