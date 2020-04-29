alias MeeseeksFlokiBench.TrendingJs

# Benchmark selecting various information from Github's list of trending
# Javascript repos.

warmup = 3
time = 9
memory_time = 3

# Test file is 349kB, and parses to ~6900 nodes
html = File.read!("data/github_trending_js.html")

Benchee.run(
  %{
    "Floki CSS" => fn -> TrendingJs.floki_trending_js_css(html) end,
    "Meeseeks CSS " => fn -> TrendingJs.meeseeks_trending_js_css(html) end,
    "Meeseeks XPath" => fn -> TrendingJs.meeseeks_trending_js_xpath(html) end
  },
  warmup: warmup,
  time: time,
  memory_time: memory_time
)
