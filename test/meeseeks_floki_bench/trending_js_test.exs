defmodule MeeseeksFlokiBench.TrendingJsTest do
  use ExUnit.Case

  alias MeeseeksFlokiBench.TrendingJs

  @html File.read!("data/github_trending_js.html")

  test "floki result equals meeseeks css result" do
    assert TrendingJs.floki_trending_js_css(@html) ==
           TrendingJs.meeseeks_trending_js_css(@html)
  end

  test "meeseeks css result equals meeseeks xpath result" do
    assert TrendingJs.meeseeks_trending_js_css(@html) ==
           TrendingJs.meeseeks_trending_js_xpath(@html)
  end
end
