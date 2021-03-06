using Test,
      DataFrames,
      Jib

include("core.jl")
include("encoder.jl")
include("decoder.jl")
include("roundtrip.jl")


@testset "TickType" begin

  @test Jib.Reader.Decoder.tickname( 0) == "BID_SIZE"

  @test Jib.Reader.Decoder.tickname(90) == "DELAYED_HALTED"

  @test Jib.Reader.Decoder.tickname(99) == "ETF_NAV_LOW"

end
