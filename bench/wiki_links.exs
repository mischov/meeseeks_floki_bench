alias MeeseeksFlokiBench.WikiLinks

# Benchmark selecting every link from a particular Wikipedia article to
# other Wikipedia articles.

warmup = 5
time = 15

# Test file is 99kB, and parses to ~2700 nodes
html = File.read!("data/wikipedia_hyperlink.html")

Benchee.run%{
  "Floki select links" => fn -> WikiLinks.floki_wiki_links(html) end,
  "Meeseeks CSS select links" => fn ->
    WikiLinks.meeseeks_css_wiki_links(html)
  end,
  "Meeseeks XPath select links" => fn ->
    WikiLinks.meeseeks_xpath_wiki_links(html)
  end
}, warmup: warmup, time: time
