# Meeseeks vs. Floki Performance

A performance comparsion between the Elixir language HTML parsing libraries [Meeseeks](https://github.com/mischov/meeseeks) and [Floki](https://github.com/philss/floki).

Performance benchmarks should always be considered with some skepticism.

Benchmarking is hard to do well, and often - intentionally or not - benchmarks may favor one implementation's strengths over another in a way that makes one look better but doesn't really help users.

For these benchmarks I have tried to focus on potential real-world-type scenarios that people might find helpful, but if performance matters consider benchmarking the two for your particular problem.

### Config

Floki is benchmarked using the `html5ever` parser.

Performance characteristics are different for the `mochiweb_html` parser, but I strongly recommend always using the `html5ever` parser unless you're sure malformed HTML won't be a problem.

### Setup

Your OS is (probably) constantly changing your processor speed (to save energy and reduce heat), which leads to inconsistent results when benchmarking.

Before running benchmarks, set processors to some fixed speed. For Debian instructions on how to do this, see [here](https://wiki.debian.org/HowTo/CpuFrequencyScaling).

Thanks to [this article](https://medium.com/learn-elixir/speed-up-data-access-in-elixir-842617030514) for pointing this out.

## The "Wiki Links" Benchmark

The scenario tested by "Wiki Links" is simple: select every link from a particular Wikipedia article to other Wikipedia articles.

This scenario is intended to mimic a simple crawler that is looking on each page for more links to follow.

The test data used is 99Kb and parses to ~2,700 nodes.

For XPath, I test both a naive solution that is closely related to the CSS solution and a more optimized version that avoids an early filter.

```
$ MIX_ENV=prod mix compile
$ MIX_ENV=prod mix run bench/wiki_links.exs
Benchmarking Floki CSS...
Benchmarking Meeseeks CSS...
Benchmarking Meeseeks XPath naive...
Benchmarking Meeseeks XPath optimized...

Name                               ips        average  deviation         median
Meeseeks CSS                     92.98       10.75 ms     ±3.33%       10.67 ms
Meeseeks XPath optimized         85.49       11.70 ms     ±1.87%       11.67 ms
Floki CSS                        76.99       12.99 ms     ±9.44%       12.92 ms
Meeseeks XPath naive             71.36       14.01 ms     ±1.82%       13.96 ms

Comparison:
Meeseeks CSS                     92.98
Meeseeks XPath optimized         85.49 - 1.09x slower
Floki CSS                        76.99 - 1.21x slower
Meeseeks XPath naive             71.36 - 1.30x slower
```

If you're going to be building a simple crawler where all you care about is searching a page for links, either Meeseeks or Floki will work, though Meeseeks tends to be a little faster.

[Implementation](https://github.com/mischov/meeseeks_floki_bench/blob/master/lib/meeseeks_floki_bench/wiki_links.ex)

## The "Trending JS" Benchmark

"Trending JS" represents a simple scenario where, overwhelmed by the churn in the JS ecosystem, you want a quick way to check what JS libraries are trending on Gibhub today, returning the name, total stars, and stars today for each.

This scenario mimics the use case of selecting a list of items from some HTML page and then extracting data from each of these items.

The test data used is 349Kb and parses to ~6,900 nodes.

```
$ MIX_ENV=prod mix compile
$ MIX_ENV=prod mix run bench/trending_js.exs
Benchmarking Floki CSS...
Benchmarking Meeseeks CSS ...
Benchmarking Meeseeks XPath...

Name                     ips        average  deviation         median
Meeseeks CSS           23.73       42.15 ms     ±1.10%       42.06 ms
Meeseeks XPath         21.64       46.22 ms     ±0.95%       46.21 ms
Floki CSS              16.80       59.51 ms     ±2.18%       59.27 ms

Comparison:
Meeseeks CSS           23.73
Meeseeks XPath         21.64 - 1.10x slower
Floki CSS              16.80 - 1.41x slower
```

Meeseeks avoids some data manipulation that Floki does, so both Meeseeks implementations come out ahead of Floki in this benchmark. If this scenario resembles your use case, it might be worth considering Meeseeks for performance reasons.

[Implementation](https://github.com/mischov/meeseeks_floki_bench/blob/master/lib/meeseeks_floki_bench/trending_js.ex)

## Further Benchmarks

If you have an idea for a useful, real-world inspired benchmark, please open an issue.

Contributions are welcome.
