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

Results vary a bit, probably due to GC, and either library may end up the faster for a given run. Generally results look something like:

```
$ MIX_ENV=prod mix compile
$ MIX_ENV=prod mix run bench/wiki_links.exs
Benchmarking Floki select links...
Benchmarking Meeseeks select links...

Name                            ips        average  deviation         median
Meeseeks select links         66.05       15.14 ms    ±28.50%       13.72 ms
Floki select links            63.56       15.73 ms    ±21.04%       15.17 ms

Comparison:
Meeseeks select links         66.05
Floki select links            63.56 - 1.04x slower
```

If you're going to be building a simple crawler where all you care about is searching a page for links, both Meeseeks and Floki will probably perform similarly.

[Implementation](https://github.com/mischov/meeseeks_floki_bench/blob/master/lib/meeseeks_floki_bench/wiki_links.ex)

## The "Trending JS" Benchmark

"Trending JS" represents a simple scenario where, overwhelmed by the churn in the JS ecosystem, you want a quick way to check what JS libraries are trending on Gibhub today, returning the name, total stars, and stars today for each.

This scenario mimics the use case of selecting a list of items from some HTML page and then extracting data from each of these items.

The test data used is 349Kb and parses to ~6,900 nodes.

Because of differences in the selection process between Meeseeks and Floki, Meeseeks tends to come out a bit ahead in this benchmark, with results like:

```
$ MIX_ENV=prod mix compile
$ MIX_ENV=prod mix run bench/trending_js.exs
Benchmarking Floki select repos...
Benchmarking Meeseeks select repos...

Name                            ips        average  deviation         median
Meeseeks select repos         12.65       79.06 ms     ±9.82%       80.70 ms
Floki select repos             9.11      109.78 ms    ±15.82%      113.71 ms

Comparison:
Meeseeks select repos         12.65
Floki select repos             9.11 - 1.39x slower
```

If this scenario resembles your use case, it might be worth considering Meeseeks for performance reasons.

[Implementation](https://github.com/mischov/meeseeks_floki_bench/blob/master/lib/meeseeks_floki_bench/trending_js.ex)

## Further Benchmarks

If you have an idea for a useful, real-world inspired benchmark, please open an issue.

Contributions are welcome.
