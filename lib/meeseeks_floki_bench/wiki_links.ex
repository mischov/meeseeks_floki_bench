defmodule MeeseeksFlokiBench.WikiLinks do
  @moduledoc """
  Functions to benchmark selecting every link from a particular Wikipedia
  article to other Wikipedia articles.
  """

  import Meeseeks.CSS

  # Floki

  def floki_wiki_links(html) do
    Floki.find(html, "#mw-content-text > p a[href^=\"/wiki/\"]")
    |> Enum.map(&Floki.attribute(&1, "href"))
  end

  # Meeseeks

  def meeseeks_wiki_links(html) do
    Meeseeks.all(html, css("#mw-content-text > p a[href^=\"/wiki/\"]"))
    |> Enum.map(&Meeseeks.attr(&1, "href"))
  end
end
