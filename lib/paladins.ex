defmodule Exrez.Paladins do
  import Exrez, only: [api_call: 3]

  def champion_ranks(platform, player) do
    api_call(platform, "getchampionranks", "/#{player}")
  end

  def champions(platform, language \\ 1) do
    api_call(platform, "getchampions", "/#{language}")
  end

  def champion_skins(platform, champion_id, language \\ 1) do
    api_call(platform, "getchampionskins", "/#{champion_id}/#{language}")
  end
end
