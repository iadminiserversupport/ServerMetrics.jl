module ServerMetrics

export utilization,
       threshold_status,
       load_status,
       memory_status,
       disk_status,
       metric_summary

"""
    utilization(used, total)

Calculate utilization as a percentage.

Returns `0.0` when `total` is zero.
"""
function utilization(used::Real, total::Real)
    total == 0 && return 0.0
    return (used / total) * 100
end

"""
    threshold_status(value; warning=80.0, critical=90.0)

Classify a metric value as `:ok`, `:warning`, or `:critical`.
"""
function threshold_status(
    value::Real;
    warning::Real=80.0,
    critical::Real=90.0,
)
    critical < warning && throw(ArgumentError("critical must be >= warning"))

    if value >= critical
        return :critical
    elseif value >= warning
        return :warning
    else
        return :ok
    end
end

"""
    load_status(load; warning=5.0, critical=10.0)

Classify a server load value using configurable thresholds.
"""
function load_status(
    load::Real;
    warning::Real=5.0,
    critical::Real=10.0,
)
    return threshold_status(load; warning=warning, critical=critical)
end

"""
    memory_status(used, total; warning=80.0, critical=90.0)

Calculate memory utilization and return `(percentage, status)`.
"""
function memory_status(
    used::Real,
    total::Real;
    warning::Real=80.0,
    critical::Real=90.0,
)
    percentage = utilization(used, total)
    return percentage, threshold_status(
        percentage;
        warning=warning,
        critical=critical,
    )
end

"""
    disk_status(used, total; warning=80.0, critical=90.0)

Calculate disk utilization and return `(percentage, status)`.
"""
function disk_status(
    used::Real,
    total::Real;
    warning::Real=80.0,
    critical::Real=90.0,
)
    percentage = utilization(used, total)
    return percentage, threshold_status(
        percentage;
        warning=warning,
        critical=critical,
    )
end

"""
    metric_summary(metrics)

Return a summary of named numeric server metrics.

`metrics` should be an `AbstractDict` whose values are numeric.
"""
function metric_summary(metrics::AbstractDict)
    isempty(metrics) && return (
        count=0,
        minimum=0.0,
        maximum=0.0,
        average=0.0,
    )

    metric_values = Float64[Float64(v) for v in Base.values(metrics)]

    return (
        count=length(metric_values),
        minimum=minimum(metric_values),
        maximum=maximum(metric_values),
        average=sum(metric_values) / length(metric_values),
    )
end

end
