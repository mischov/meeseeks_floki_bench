defmodule MeeseeksFlokiBench.WikiLinksTest do
  use ExUnit.Case

  alias MeeseeksFlokiBench.WikiLinks

  @html File.read!("data/wikipedia_hyperlink.html")

  # Comparing sets because of ordering differences
  test "floki result equals meeseeks css result" do
    assert MapSet.new(WikiLinks.floki_wiki_links_css(@html)) ==
           MapSet.new(WikiLinks.meeseeks_wiki_links_css(@html))
  end

  test "meeseeks css result equals meeseeks xpath naive result" do
    assert WikiLinks.meeseeks_wiki_links_css(@html) ==
           WikiLinks.meeseeks_wiki_links_xpath_naive(@html)
  end

  test "meeseeks xpath naive result equals meeseeks xpath optimized result" do
    assert WikiLinks.meeseeks_wiki_links_xpath_naive(@html) ==
           WikiLinks.meeseeks_wiki_links_xpath_optimized(@html)
  end
end
