defmodule MeeseeksFlokiBench.WikiLinksTest do
  use ExUnit.Case

  alias MeeseeksFlokiBench.WikiLinks

  @html File.read!("data/wikipedia_hyperlink.html")

  # Comparing sets because of ordering differences
  test "floki result equals meeseeks css result" do
    assert MapSet.new(WikiLinks.floki_wiki_links(@html)) ==
           MapSet.new(WikiLinks.meeseeks_css_wiki_links(@html))
  end

  test "meeseeks css result equals meeseeks xpath result" do
    assert WikiLinks.meeseeks_css_wiki_links(@html) ==
           WikiLinks.meeseeks_xpath_wiki_links(@html)
  end
end
