defmodule Option.MixProject do
  use Mix.Project

  def project do
    [
      app: :option,
      version: "0.1.0",
      description: "THe option monad for Elixir.",
      pakcage: package(),
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      files: ~w(CHANGELOG* config LICENSE* README* lib mix.exs priv .formatter.exs),
      links: %{
        "GitHub" => "https://github.com/turfapp/option"
      }
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.38", only: :dev, runtime: false},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false}
    ]
  end
end
