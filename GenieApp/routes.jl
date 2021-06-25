using Genie.Router, Genie.Renderer, Genie.Exceptions, JSON3

route("/") do
  serve_static_file("welcome.html")
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
