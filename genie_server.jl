using Base: default_color_error
using Genie, Genie.Router, Genie.Renderer, Genie.Exceptions, JSON3

route("/") do
  throw(ExceptionalResponse(redirect(:greeting)))
end

route("/greeting", named = :greeting) do
   "Welcome to Genie! This site is served by Julia $(Base.VERSION) with $(Threads.nthreads()) threads."
end

route("/random", named = :random) do
  num = 1
  if haskey(@params, :num)
    num = parse(Int64, @params(:num))
  end
  JSON3.write(rand(Int, num))
end

#up(8100, async = false)
#up(8100)
startup(8100)