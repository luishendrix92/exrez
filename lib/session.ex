defmodule Exrez.Session do
  # create :: Atom -> Eff() Tuple :: Exception Prone
  def create(platform) do
    response =
      Exrez.build_url(platform, "createsession")
      |> HTTPoison.get!()
      |> Map.get(:body)
      |> Poison.decode!()
    
    case response do
      %{"ret_msg" => "Approved", "session_id" => session_id} ->
        System.put_env(env_var(platform), session_id)
        {:ok, session_id}
      %{"ret_msg" => err} ->
        System.put_env(env_var(platform), "null")
        {:error, err}
    end
  end

  # env_var :: Atom -> String -> String :: Exception Prone
  def env_var(platform) do
    case platform do
      :paladins_pc   -> "PALADINS_PC_SESSION"
      :paladins_xbox -> "PALADINS_XBOX_SESSION"
      :paladins_ps4  -> "PALADINS_PS4_SESSION"
      :smite_pc      -> "SMITE_PC_SESSION"
      :smite_xbox    -> "SMITE_XBOX_SESSION"
      :smite_ps4     -> "SMITE_PS4_SESSION"
      :realm_pc      -> "REALM_PC_SESSION"
    end
  end

  # utc_string :: String :: Exception Prone
  def utc_string() do
    DateTime.utc_now()
    |> Timex.format!("%Y%m%d%H%M%S", :strftime)
  end

  # signature :: String -> String -> String -> String -> String
  def signature(dev_id, auth_key, method, date) do
    input = "#{dev_id}#{method}#{auth_key}#{date}"

    :crypto.hash(:md5, input)
    |> Base.encode16(case: :lower)
  end
end
