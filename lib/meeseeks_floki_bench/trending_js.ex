defmodule MeeseeksFlokiBench.TrendingJs do
  @moduledoc """
  Functions to benchmark selecting various information from Github's list of
  trending Javascript repos.
  """
  import Meeseeks.CSS
  import Meeseeks.XPath

  # Floki

  def floki_trending_js_css(html) do
    Floki.find(html, "ol.repo-list > li")
    |> Enum.map(fn(result) ->
      %{name: floki_repo_name_css(result),
        stars: floki_repo_stars_css(result),
        stars_today: floki_repo_stars_today_css(result)}
    end)
  end

  defp floki_repo_name_css(result) do
    Floki.find(result, "div h3 a")
    |> List.first()
    |> Floki.text(deep: false)
    |> String.trim()
  end

  defp floki_repo_stars_css(result) do
    Floki.find(result, "div:nth-child(4) > :nth-child(3)")
    |> List.first()
    |> Floki.text(deep: false)
    |> String.trim()
  end

  defp floki_repo_stars_today_css(result) do
    Floki.find(result, "div:nth-child(4) > :nth-child(6)")
    |> List.first()
    |> Floki.text(deep: false)
    |> String.trim()
  end

  # Meeseeks CSS

  def meeseeks_trending_js_css(html) do
    Meeseeks.all(html, css("ol.repo-list > li"))
    |> Enum.map(fn(result) ->
      %{name: meeseeks_repo_name_css(result),
        stars: meeseeks_repo_stars_css(result),
        stars_today: meeseeks_repo_stars_today_css(result)}
    end)
  end

  defp meeseeks_repo_name_css(result) do
    Meeseeks.one(result, css("div h3 a"))
    |> Meeseeks.own_text() # Already trims text, so no trim
  end

  defp meeseeks_repo_stars_css(result) do
    Meeseeks.one(result, css("div:nth-child(4) > :nth-child(3)"))
    |> Meeseeks.own_text()
  end

  defp meeseeks_repo_stars_today_css(result) do
    Meeseeks.one(result, css("div:nth-child(4) > :nth-child(6)"))
    |> Meeseeks.own_text()
  end

  # Meeseeks XPath

  def meeseeks_trending_js_xpath(html) do
    Meeseeks.all(html, xpath("ol[contains(@class, 'repo-list')]/li"))
    |> Enum.map(fn(result) ->
      %{name: meeseeks_repo_name_xpath(result),
        stars: meeseeks_repo_stars_xpath(result),
        stars_today: meeseeks_repo_stars_today_xpath(result)}
    end)
  end

  defp meeseeks_repo_name_xpath(result) do
    Meeseeks.one(result, xpath("./div/h3/a"))
    |> Meeseeks.own_text() # Already trims text, so no trim
  end

  defp meeseeks_repo_stars_xpath(result) do
    Meeseeks.one(result, xpath("./div[4]/*[3]"))
    |> Meeseeks.own_text()
  end

  defp meeseeks_repo_stars_today_xpath(result) do
    Meeseeks.one(result, xpath("./div[4]/*[6]"))
    |> Meeseeks.own_text()
  end
end
