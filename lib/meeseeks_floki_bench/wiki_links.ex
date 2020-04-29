defmodule MeeseeksFlokiBench.WikiLinks do
  @moduledoc """
  Functions to benchmark selecting every link from a particular Wikipedia
  article to other Wikipedia articles.
  """

  import Meeseeks.CSS
  import Meeseeks.XPath

  # Floki

  def floki_wiki_links_css(html) do
    Floki.find(html, "#mw-content-text > p a[href^=\"/wiki/\"]")
    |> Floki.attribute("href")
  end

  # Meeseeks CSS

  def meeseeks_wiki_links_css(html) do
    Meeseeks.all(html, css("#mw-content-text > p a[href^=\"/wiki/\"]"))
    |> Enum.map(&Meeseeks.attr(&1, "href"))
  end

  # Meeseeks XPath Naive

  def meeseeks_wiki_links_xpath_naive(html) do
    Meeseeks.all(html, xpath("div[@id='mw-content-text']/p//a[starts-with(@href, '/wiki/')]"))
    |> Enum.map(&Meeseeks.attr(&1, "href"))
  end

  # Meeseeks XPath Optimized

  def meeseeks_wiki_links_xpath_optimized(html) do
    Meeseeks.all(
      html,
      xpath("/html/body/div[3]/div[3]/div[4]/p//a[starts-with(@href, '/wiki/')]")
    )
    |> Enum.map(&Meeseeks.attr(&1, "href"))
  end
end
