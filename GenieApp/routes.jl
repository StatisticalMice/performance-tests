using Genie.Router, Genie.Renderer.Html, Genie.Renderer.Json

route("/") do
  serve_static_file("welcome.html")
end

const GREETING = "Welcome to Genie! This site is served by Julia $(Base.VERSION) with $(Threads.nthreads()) threads."

route("/greeting", named = :greeting) do
  html(GREETING)
end

route("/random", named = :random) do
  p = haskey(_params_(), :num) ? _params_()(:num) : "1"
  num = tryparse(Int32, p)
  if (num === nothing || num < 1) 
    num = 1
  end

  json(rand(Int, num))
end
