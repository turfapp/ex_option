defmodule ExOption.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_option,
      version: "0.1.0",
      description: "The Option and Either monads for Elixir.",
      package: package(),
      elixir: "~> 1.0",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      files: ~w(CHANGELOG* LICENSE* README* lib mix.exs .formatter.exs),
      links: %{
        "GitHub" => "https://github.com/turfapp/ex_option"
      }
    ]
  end

  def application, do: []

  defp deps do
    [
      {:ex_doc, "~> 0.38", only: :dev, runtime: false},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false}
    ]
  end
end
