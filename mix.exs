defmodule Exrez.MixProject do
  use Mix.Project

  def project do
    [
      app: :exrez,
      version: "0.2.1",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      description: description(),
      deps: deps(),
      package: package()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:timex, "~> 3.1"},
      {:httpoison, "~> 1.0"},
      {:poison, "~> 3.1"},
      {:ex_doc, "~> 0.19.0", only: :dev, runtime: false}
    ]
  end

  defp description() do
    """
    Elixir package for the HiRez API which provides data about its games and lets you bypass all the session generation and url-building logic and gives you a coherent API for all its games' endpoints.
    """
  end

  defp package() do
    [
      licenses: ["MIT"],
      links: %{
        "Github": "https://github.com/luishendrix92/exrez",
        "Documentation": "https://github.com/luishendrix92/exrez/wiki",
        "Author": "https://kozmicluis.com"
      }
    ]
  end
end
