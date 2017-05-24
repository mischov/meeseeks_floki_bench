alias MeeseeksFlokiBench.WikiLinks

# Benchmark selecting every link from a particular Wikipedia article to
# other Wikipedia articles.

warmup = 5
time = 15

# Test file is 99kB, and parses to ~2700 nodes
html = File.read!("data/wikipedia_hyperlink.html")

Benchee.run%{
  "Floki CSS" => fn -> WikiLinks.floki_wiki_links_css(html) end,
  "Meeseeks CSS" => fn -> WikiLinks.meeseeks_wiki_links_css(html) end,
  "Meeseeks XPath naive" => fn ->
    WikiLinks.meeseeks_wiki_links_xpath_naive(html)
  end,
  "Meeseeks XPath optimized" => fn ->
    WikiLinks.meeseeks_wiki_links_xpath_optimized(html)
  end
}, warmup: warmup, time: time
