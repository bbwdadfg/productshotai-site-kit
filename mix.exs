defmodule ProductshotaiSiteKit.MixProject do
  use Mix.Project

  def project do
    [
      app: :productshotai_site_kit,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      source_url: "https://github.com/bbwdadfg/productshotai-site-kit",
      homepage_url: "https://productshotai.app"
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.31", only: :dev, runtime: false}
    ]
  end

  defp description do
    "URL helpers and metadata utilities for ProductShot AI - AI product photography generator for ecommerce product photos"
  end

  defp package do
    [
      name: "productshotai_site_kit",
      licenses: ["MIT"],
      links: %{
        "Website" => "https://productshotai.app",
        "GitHub" => "https://github.com/bbwdadfg/productshotai-site-kit"
      },
      files: ["lib/productshotai_site_kit.ex", "mix.exs", "README.md", "LICENSE"]
    ]
  end
end
