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
Elixir 1.10.1
Erlang 22.3.3

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
Meeseeks CSS                     85.04       11.76 ms     ±8.55%       11.46 ms       16.75 ms
Meeseeks XPath optimized         78.01       12.82 ms     ±5.05%       12.63 ms       15.77 ms
Floki CSS                        77.36       12.93 ms     ±8.32%       12.70 ms       16.45 ms
Meeseeks XPath naive             61.23       16.33 ms     ±6.61%       16.03 ms       20.19 ms

Comparison: 
Meeseeks CSS                     85.04
Meeseeks XPath optimized         78.01 - 1.09x slower +1.06 ms
Floki CSS                        77.36 - 1.10x slower +1.17 ms
Meeseeks XPath naive             61.23 - 1.39x slower +4.57 ms

Memory usage statistics:

Name                        Memory usage
Meeseeks CSS                     0.77 MB
Meeseeks XPath optimized         1.09 MB - 1.41x memory usage +0.32 MB
Floki CSS                        3.11 MB - 4.05x memory usage +2.35 MB
Meeseeks XPath naive             2.15 MB - 2.80x memory usage +1.38 MB

**All measurements for memory usage were the same**
```

If you're going to be building a simple crawler where all you care about is searching a page for links, either Meeseeks or Floki will perform similarly (though Meeseeks will probably use less memory).

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
Elixir 1.10.1
Erlang 22.3.3

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
Meeseeks CSS           23.22       43.07 ms     ±2.73%       42.79 ms       47.22 ms
Meeseeks XPath         19.47       51.35 ms     ±4.03%       50.77 ms       60.82 ms
Floki CSS              14.01       71.39 ms     ±3.85%       71.31 ms       83.36 ms

Comparison: 
Meeseeks CSS           23.22
Meeseeks XPath         19.47 - 1.19x slower +8.28 ms
Floki CSS              14.01 - 1.66x slower +28.32 ms

Memory usage statistics:

Name              Memory usage
Meeseeks CSS           3.66 MB
Meeseeks XPath         6.57 MB - 1.80x memory usage +2.91 MB
Floki CSS             22.23 MB - 6.08x memory usage +18.57 MB

**All measurements for memory usage were the same**
```

Meeseeks avoids some converting between data formats that Floki does, so the Meeseeks implementations tend to come out ahead of Floki in this benchmark.

[Implementation](https://github.com/mischov/meeseeks_floki_bench/blob/master/lib/meeseeks_floki_bench/trending_js.ex)

## Further Benchmarks

If you have an idea for a useful, real-world inspired benchmark, please open an issue.

Contributions are welcome.
