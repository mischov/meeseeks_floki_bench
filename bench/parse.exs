# Benchmark parsing the html from Github's list of trending Javascript repos

warmup = 3
time = 9

# Test file is 349kB, and parses to ~6900 nodes
html = File.read!("data/github_trending_js.html")

Benchee.run%{
  "Floki Parse" => fn -> Floki.parse(html) end,
  "Meeseeks Parse " => fn -> Meeseeks.parse(html) end
}, warmup: warmup, time: time
