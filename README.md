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
Operating System: macOS
CPU Information: Intel(R) Core(TM) i7-5557U CPU @ 3.10GHz
Number of Available Cores: 4
Available memory: 8 GB
Elixir 1.8.1
Erlang 21.2.4

Benchmark suite executing with the following configuration:
warmup: 3 s
time: 9 s
memory time: 3 s
parallel: 1
inputs: none specified
Estimated total run time: 1 min


Benchmarking Floki CSS...
Benchmarking Meeseeks CSS...
Benchmarking Meeseeks XPath naive...
Benchmarking Meeseeks XPath optimized...

Name                               ips        average  deviation         median         99th %
Meeseeks CSS                     82.89       12.06 ms     ±3.30%       11.93 ms       14.05 ms
Floki CSS                        82.85       12.07 ms     ±7.36%       12.04 ms       14.31 ms
Meeseeks XPath optimized         69.23       14.44 ms     ±4.54%       14.45 ms       17.39 ms
Meeseeks XPath naive             61.78       16.19 ms     ±4.10%       16.02 ms       19.00 ms

Comparison:
Meeseeks CSS                     82.89
Floki CSS                        82.85 - 1.00x slower
Meeseeks XPath optimized         69.23 - 1.20x slower
Meeseeks XPath naive             61.78 - 1.34x slower

Memory usage statistics:

Name                        Memory usage
Meeseeks CSS                     0.77 MB
Floki CSS                        2.92 MB - 3.79x memory usage
Meeseeks XPath optimized         1.09 MB - 1.41x memory usage
Meeseeks XPath naive             2.15 MB - 2.79x memory usage

**All measurements for memory usage were the same**
```

If you're going to be building a simple crawler where all you care about is searching a page for links, either Meeseeks or Floki will perform similarly.

[Implementation](https://github.com/mischov/meeseeks_floki_bench/blob/master/lib/meeseeks_floki_bench/wiki_links.ex)

## The "Trending JS" Benchmark

"Trending JS" represents a simple scenario where, overwhelmed by the churn in the JS ecosystem, you want a quick way to check what JS libraries are trending on Gibhub today, returning the name, total stars, and stars today for each.

This scenario mimics the use case of selecting a list of items from some HTML page and then extracting data from each of these items.

The test data used is 349Kb and parses to ~6,900 nodes.

```
$ MIX_ENV=prod mix compile
$ MIX_ENV=prod mix run bench/trending_js.exs
Operating System: macOS
CPU Information: Intel(R) Core(TM) i7-5557U CPU @ 3.10GHz
Number of Available Cores: 4
Available memory: 8 GB
Elixir 1.8.1
Erlang 21.2.4

Benchmark suite executing with the following configuration:
warmup: 3 s
time: 9 s
memory time: 3 s
parallel: 1
inputs: none specified
Estimated total run time: 45 s


Benchmarking Floki CSS...
Benchmarking Meeseeks CSS ...
Benchmarking Meeseeks XPath...

Name                     ips        average  deviation         median         99th %
Meeseeks CSS           22.20       45.04 ms     ±4.54%       44.16 ms       52.01 ms
Meeseeks XPath         18.45       54.21 ms     ±4.51%       53.53 ms       61.46 ms
Floki CSS              18.23       54.86 ms     ±5.63%       53.95 ms       68.75 ms

Comparison:
Meeseeks CSS           22.20
Meeseeks XPath         18.45 - 1.20x slower
Floki CSS              18.23 - 1.22x slower

Memory usage statistics:

Name              Memory usage
Meeseeks CSS           3.82 MB
Meeseeks XPath         6.75 MB - 1.77x memory usage
Floki CSS             14.69 MB - 3.84x memory usage

**All measurements for memory usage were the same**
```

Meeseeks avoids some data manipulation that Floki does, so the Meeseeks implementations come out equal to or ahead of Floki in this benchmark.

[Implementation](https://github.com/mischov/meeseeks_floki_bench/blob/master/lib/meeseeks_floki_bench/trending_js.ex)

## Further Benchmarks

If you have an idea for a useful, real-world inspired benchmark, please open an issue.

Contributions are welcome.
