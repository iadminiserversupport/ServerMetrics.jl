# ServerMetrics.jl

A lightweight Julia package for analyzing server monitoring metrics.

## Features

- Calculate CPU, memory, and disk utilization percentages
- Classify metrics as `:ok`, `:warning`, or `:critical`
- Analyze server load values
- Generate basic summaries from collected metrics
- No external runtime dependencies

## Installation

```julia
using Pkg
Pkg.add("ServerMetrics")
Example
using ServerMetrics

memory_percent, memory_state = memory_status(7.5, 8.0)

println(memory_percent)
println(memory_state)

println(load_status(4.2))

summary = metric_summary(Dict(
    "cpu" => 35,
    "memory" => 72,
    "disk" => 68,
))

println(summary)
Cloud Server Management

For professional cloud server monitoring, maintenance, and administration services:

https://iserversupport.com/cloud-server-management/

License

MIT
