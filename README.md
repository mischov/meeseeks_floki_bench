# Meeseeks vs. Floki Performance

A performance comparsion between the Elixir language HTML parsing libraries [Meeseeks](https://github.com/mischov/meeseeks) and [Floki](https://github.com/philss/floki).

Performance benchmarks should always be considered with some skepticism.

Benchmarking is hard to do well, and often - intentionally or not - benchmarks may favor one implementation's strengths over another in a way that makes one look better but doesn't really help users.

For these benchmarks I have tried to focus on potential real-world-type scenarios that people might find helpful, but Meeseeks and Floki each have somewhat complicated performance characteristics, so if performance matters consider benchmarking the two for your particular problem.

### Config

Floki is benchmarked using the `html5ever` parser.

Performance characteristics are different for the `mochiweb_html` parser, but I strongly recommend always using the `html5ever` parser unless you're sure malformed HTML won't be a problem.

## The "Wiki Links" Benchmark

The scenario tested by "Wiki Links" is simple: select every link from a particular Wikipedia article to other Wikipedia articles.

This scenario is intended to mimic a simple crawler who is just looking on each page for more links to follow.

The test data used is 99Kb and parses to ~2,700 nodes.

The Meeseeks XPath chosen is a naive one similar to the CSS selectors, and unsurprisingly it runs slower than either CSS version. A more optimized solution would avoid a lot of filtering and run in around the same time as the CSS versions, but I thought it would be more useful to see how similar solutions stacked up.

```
$ MIX_ENV=prod mix compile
$ MIX_ENV=prod mix run bench/wiki_links.exs
Benchmarking Floki select links...
Benchmarking Meeseeks CSS select links...
Benchmarking Meeseeks XPath select links...

Name                                  ips        average  deviation         median
Meeseeks CSS select links           75.95       13.17 ms    ±28.88%       10.85 ms
Floki select links                  63.05       15.86 ms    ±20.40%       15.09 ms
Meeseeks XPath select links         53.03       18.86 ms    ±18.97%       18.80 ms

Comparison:
Meeseeks CSS select links           75.95
Floki select links                  63.05 - 1.20x slower
Meeseeks XPath select links         53.03 - 1.43x slower
```

If you're going to be building a simple crawler where all you care about is searching a page for links, both Meeseeks and Floki will probably perform similarly. If you're going to use XPath selectors, avoid early filters if you can.

[Implementation](https://github.com/mischov/meeseeks_floki_bench/blob/master/lib/meeseeks_floki_bench/wiki_links.ex)

## The "Trending JS" Benchmark

"Trending JS" represents a simple scenario where, overwhelmed by the churn in the JS ecosystem, you want a quick way to check what JS libraries are trending on Gibhub today, returning the name, total stars, and stars today for each.

This scenario mimics the use case of selecting a list of items from some HTML page and then extracting data from each of these items.

The test data used is 349Kb and parses to ~6,900 nodes.

Because of differences in the selection process between Meeseeks and Floki, both Meeseeks implementations come out ahead of Floki in this benchmark, and XPath tends keeps pretty close to CSS.

```
$ MIX_ENV=prod mix compile
$ MIX_ENV=prod mix run bench/trending_js.exs
Benchmarking Floki select repos...
Benchmarking Meeseeks CSS select repos...
Benchmarking Meeseeks XPath select repos...

Name                                  ips        average  deviation         median
Meeseeks CSS select repos           12.83       77.94 ms    ±13.73%       81.13 ms
Meeseeks XPath select repos         11.80       84.75 ms    ±11.00%       89.85 ms
Floki select repos                   8.84      113.18 ms    ±16.83%      123.20 ms

Comparison:
Meeseeks CSS select repos           12.83
Meeseeks XPath select repos         11.80 - 1.09x slower
Floki select repos                   8.84 - 1.45x slower
```

If this scenario resembles your use case, it might be worth considering Meeseeks for performance reasons.

[Implementation](https://github.com/mischov/meeseeks_floki_bench/blob/master/lib/meeseeks_floki_bench/trending_js.ex)

## Further Benchmarks

If you have an idea for a useful, real-world inspired benchmark, please open an issue.

Contributions are welcome.
