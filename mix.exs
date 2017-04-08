defmodule MeeseeksFlokiBench.Mixfile do
  use Mix.Project

  def project do
    [app: :meeseeks_floki_bench,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [{:benchee, "~> 0.6"},
     {:floki, "~> 0.16.0"},
     {:html5ever, "~> 0.3.0"},
     {:meeseeks, "~> 0.4.0"}]
  end
end
