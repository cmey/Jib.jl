@testset "Roundtrip" begin

  i, f, s, b = 10, 12.3, "a", false

  cl = Jib.ComboLeg(ratio=1, exchange="ex")
  cv = Jib.ConditionVolume("o", true, 1, 2, "ex")


  o = Jib.Requests.Encoder.Enc()

  o(i, f, s, b, Jib.Requests.Encoder.splat(cl)..., cv)

  m = split(String(take!(o.buf)), '\0')

  it = Iterators.Stateful(Jib.Reader.Decoder.Field.(m))

  j::Int,
  g::Float64,
  z::String,
  l::Bool = it

  cc = Jib.Reader.Decoder.slurp(Jib.ComboLeg, it)

  cw = Jib.Reader.Decoder.slurp(Jib.condition_map[Jib.Reader.Decoder.slurp(Jib.ConditionType, it)], it)

  @test i == j
  @test f == g
  @test s == z
  @test b == l
  @test cl == cc
  @test cv == cw

  popfirst!(it)
  @test isempty(it)

end
