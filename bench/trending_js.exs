alias MeeseeksFlokiBench.TrendingJs

# Benchmark selecting various information from Github's list of trending
# Javascript repos.

warmup = 5
time = 15

# Test file is 349kB, and parses to ~6900 nodes
html = File.read!("data/github_trending_js.html")

Benchee.run%{
  "Floki select repos" => fn -> TrendingJs.floki_trending_js(html) end,
  "Meeseeks CSS select repos" => fn ->
    TrendingJs.meeseeks_css_trending_js(html)
  end,
  "Meeseeks XPath select repos" => fn ->
    TrendingJs.meeseeks_xpath_trending_js(html)
  end
}, warmup: warmup, time: time
