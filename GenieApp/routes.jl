using Genie.Router, Genie.Renderer.Html, Genie.Renderer.Json

route("/") do
  html("Welcome to Genie! This site is served by Julia $(Base.VERSION) with $(Threads.nthreads()) threads.")
end

route("/random") do
  json(rand(Int, parse(Int64, @params(:num, "1"))))
end
