defmodule Chopsticks.Mixfile do
  use Mix.Project

  def project do
    [app: :chopsticks,
     version: "0.0.1",
     elixir: "~> 1.2",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     aliases: ["phoenix.digest": "my_app.digest"]]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {Chopsticks, []},
     applications: [:phoenix, :phoenix_pubsub, :phoenix_html, :phoenix_ecto,
                    :cowboy, :logger, :gettext]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:phoenix, "~> 1.2.0"},
     {:phoenix_pubsub, "~> 1.0"},
     {:phoenix_html, "~> 2.6"},
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:phoenix_ecto, "~> 3.0.1"},
     {:gettext, "~> 0.11"},
     {:cowboy, "~> 1.0"},
     {:poison, "~> 2.2.0"}]
  end
end
