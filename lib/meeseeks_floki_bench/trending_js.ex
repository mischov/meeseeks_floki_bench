defmodule MeeseeksFlokiBench.TrendingJs do
  @moduledoc """
  Functions to benchmark selecting various information from Github's list of
  trending Javascript repos.
  """
  import Meeseeks.CSS
  import Meeseeks.XPath

  # Floki

  def floki_trending_js(html) do
    Floki.find(html, "ol.repo-list > li")
    |> Enum.map(fn(result) ->
      %{name: floki_repo_name(result),
        stars: floki_repo_stars(result),
        stars_today: floki_repo_stars_today(result)}
    end)
  end

  defp floki_repo_name(result) do
    Floki.find(result, "div h3 a")
    |> List.first()
    |> Floki.text(deep: false)
    |> String.trim()
  end

  defp floki_repo_stars(result) do
    Floki.find(result, ":nth-child(4) > :nth-child(3)")
    |> List.first()
    |> Floki.text(deep: false)
    |> String.trim()
  end

  defp floki_repo_stars_today(result) do
    Floki.find(result, ":nth-child(4) > :nth-child(6)")
    |> List.first()
    |> Floki.text(deep: false)
    |> String.trim()
  end

  # Meeseeks CSS

  def meeseeks_css_trending_js(html) do
    Meeseeks.all(html, css("ol.repo-list > li"))
    |> Enum.map(fn(result) ->
      %{name: meeseeks_css_repo_name(result),
        stars: meeseeks_css_repo_stars(result),
        stars_today: meeseeks_css_repo_stars_today(result)}
    end)
  end

  defp meeseeks_css_repo_name(result) do
    Meeseeks.one(result, css(":nth-child(1) h3 a"))
    |> Meeseeks.own_text() # Already trims text, so no trim
  end

  defp meeseeks_css_repo_stars(result) do
    Meeseeks.one(result, css(":nth-child(4) > :nth-child(3)"))
    |> Meeseeks.own_text()
  end

  defp meeseeks_css_repo_stars_today(result) do
    Meeseeks.one(result, css(":nth-child(4) > :nth-child(6)"))
    |> Meeseeks.own_text()
  end

  # Meeseeks XPath

  def meeseeks_xpath_trending_js(html) do
    Meeseeks.all(html, xpath("ol[contains(@class, 'repo-list')]/li"))
    |> Enum.map(fn(result) ->
      %{name: meeseeks_xpath_repo_name(result),
        stars: meeseeks_xpath_repo_stars(result),
        stars_today: meeseeks_xpath_repo_stars_today(result)}
    end)
  end

  defp meeseeks_xpath_repo_name(result) do
    Meeseeks.one(result, xpath("./*[1]/h3/a"))
    |> Meeseeks.own_text() # Already trims text, so no trim
  end

  defp meeseeks_xpath_repo_stars(result) do
    Meeseeks.one(result, xpath("./*[4]/*[3]"))
    |> Meeseeks.own_text()
  end

  defp meeseeks_xpath_repo_stars_today(result) do
    Meeseeks.one(result, xpath("./*[4]/*[6]"))
    |> Meeseeks.own_text()
  end
end
