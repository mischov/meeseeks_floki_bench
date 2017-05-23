defmodule MeeseeksFlokiBench.TrendingJsTest do
  use ExUnit.Case

  alias MeeseeksFlokiBench.TrendingJs

  @html File.read!("data/github_trending_js.html")

  test "floki result equals meeseeks css result" do
    assert TrendingJs.floki_trending_js(@html) ==
           TrendingJs.meeseeks_css_trending_js(@html)
  end

  test "meeseeks css result equals meeseeks xpath result" do
    assert TrendingJs.meeseeks_css_trending_js(@html) ==
           TrendingJs.meeseeks_xpath_trending_js(@html)
  end
end
