defmodule Exrez do
  @moduledoc """
  This is the main module which contains some core functions like making requests to the corresponding Hi-Rez API endpoints.
  """

  alias Exrez.Session

  # api_call :: Atom -> String -> String -> Tuple
  def api_call(platform, method, extra_part \\ "") do
    session_id = System.get_env(Session.env_var(platform)) || "null"
    response =
      "#{build_url(platform, method, session_id)}#{extra_part}"
      |> HTTPoison.get
    
    case response do
      {:ok, %{status_code: 200, body: res}} ->
        Poison.decode(res)
        |> handle_ret_msg()
      {:ok, %{status_code: 404}} -> {:err, "Error 404 Resource not found."}
      _ -> {:err, "Request failed, possible timeout or invalid domain."}
    end
  end

  # build_url :: Atom -> String -> String -> String
  def build_url(platform, method, session_id \\ "")
  def build_url(platform, "ping", _) do
    "#{base_url(platform)}/pingjson"
  end
  def build_url(platform, method, session_id) do
    date = Session.utc_string()
    base_url = base_url(platform)
    dev_id = Application.get_env(:exrez, :dev_id, "")
    auth_key = Application.get_env(:exrez, :auth_key, "")
    hash = Session.signature(dev_id, auth_key, method, date)

    case session_id do
      "" -> "#{base_url}/#{method}json/#{dev_id}/#{hash}/#{date}"
      _  -> "#{base_url}/#{method}json/#{dev_id}/#{hash}/#{session_id}/#{date}"
    end
  end

  # handle_ret_msg :: Tuple -> Tuple
  defp handle_ret_msg({:ok, [%{"ret_msg" => nil}] = data}), do: {:ok, data}
  defp handle_ret_msg({:ok, [%{"ret_msg" => msg}]}), do: {:err, msg}
  defp handle_ret_msg({:err, _, _}), do: {:err, "Failed to parse the request response."}
  defp handle_ret_msg({:err, _}), do: {:err, "Failed to parse the request response."}
  defp handle_ret_msg(decoded_response), do: decoded_response

  # base_url :: String -> String :: Exception Prone
  defp base_url(platform) do
    case platform do
      :paladins_pc   -> "http://api.paladins.com/paladinsapi.svc"
      :paladins_xbox -> "http://api.xbox.paladins.com/paladinsapi.svc"
      :paladins_ps4  -> "http://api.ps4.paladins.com/paladinsapi.svc"
      :smite_pc      -> "http://api.smitegame.com/smiteapi.svc"
      :smite_xbox    -> "http://api.xbox.smitegame.com/smiteapi.svc"
      :smite_ps4     -> "http://api.ps4.smitegame.com/smiteapi.svc"
      :realm_pc      -> "http://api.realmroyale.com/realmapi.svc"
    end
  end
end
