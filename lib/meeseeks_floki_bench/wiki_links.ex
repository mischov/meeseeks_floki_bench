defmodule MeeseeksFlokiBench.WikiLinks do
  @moduledoc """
  Functions to benchmark selecting every link from a particular Wikipedia
  article to other Wikipedia articles.
  """

  import Meeseeks.CSS
  import Meeseeks.XPath

  # Floki

  def floki_wiki_links(html) do
    Floki.find(html, "#mw-content-text > p a[href^=\"/wiki/\"]")
    |> Floki.attribute("href")
  end

  # Meeseeks CSS

  def meeseeks_css_wiki_links(html) do
    Meeseeks.all(html, css("#mw-content-text > p a[href^=\"/wiki/\"]"))
    |> Enum.map(&Meeseeks.attr(&1, "href"))
  end

  # Meeseeks XPath

  def meeseeks_xpath_wiki_links(html) do
    # XPath could be better optimized by following a path directly to the
    # #mw-context-text div, avoiding a lot of expensive filtering, but
    # using naive solution because it is similar to what Chrome dev tools
    # would recommend.
    #
    # Only optimization is looking for div, not *, which also cuts down on
    # filtering.
    Meeseeks.all(html, xpath("div[@id='mw-content-text']/p//a[starts-with(@href, '/wiki/')]"))
    |> Enum.map(&Meeseeks.attr(&1, "href"))
  end
end
