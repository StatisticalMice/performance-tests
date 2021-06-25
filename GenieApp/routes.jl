using Genie.Router, JSON3

route("/") do
  "Welcome to Genie! This site is served by Julia $(Base.VERSION) with $(Threads.nthreads()) threads."
end

route("/random") do
 JSON3.write(rand(Int, parse(Int64, @params(:num, "1"))))
end
