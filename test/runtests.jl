using Test
using ServerMetrics

@testset "ServerMetrics" begin
    @test utilization(50, 100) == 50.0
    @test utilization(10, 0) == 0.0

    @test threshold_status(50) == :ok
    @test threshold_status(80) == :warning
    @test threshold_status(90) == :critical

    @test load_status(2) == :ok
    @test load_status(5) == :warning
    @test load_status(10) == :critical

    memory_percent, memory_state = memory_status(8, 10)
    @test memory_percent == 80.0
    @test memory_state == :warning

    disk_percent, disk_state = disk_status(95, 100)
    @test disk_percent == 95.0
    @test disk_state == :critical

    summary = metric_summary(Dict(
        "cpu" => 20,
        "memory" => 60,
        "disk" => 80,
    ))

    @test summary.count == 3
    @test summary.minimum == 20.0
    @test summary.maximum == 80.0
    @test summary.average == 160 / 3
end
