using Genie.Router, Genie.Renderer.Html, Genie.Renderer.Json

route("/") do
  serve_static_file("welcome.html")
end

if haskey(ENV, "TURN_ON_LOGGING")
  const GREETING = "Welcome to Genie.jl! This site is served by Julia $(Base.VERSION) with $(Threads.nthreads()) threads. Logging is turned on."
else
  const GREETING = "Welcome to Genie.jl! This site is served by Julia $(Base.VERSION) with $(Threads.nthreads()) threads. Logging is turned off."
end

route("/greeting", named = :greeting) do
  html(GREETING)
end

#=
route("/random", named = :random) do
  p = haskey(_params_(), :num) ? _params_()(:num) : "1"
  num = tryparse(Int32, p)
  if (num === nothing || num < 1) 
    num = 1
  end

  json(rand(Int, num))
end
=#

route("/random", named = :random) do
  json(rand(Int, 1000))
end
