using HTTP, Sockets, JSON3, Logging
using HTTP.URIs: queryparams, URI

const ROUTER = HTTP.Router()

function serveWelcome(req::HTTP.Request)
    return HTTP.Response(200, "Welcome to Genie! This site is served by Julia $(Base.VERSION) with $(Threads.nthreads()) threads.")
end

function serveRandom(req::HTTP.Request)
    num = parse(Int, get(queryparams(URI(req.target)), "num", "1"))

    return HTTP.Response(200, JSON3.write(rand(Int, num)))
end

HTTP.@register(ROUTER, "GET", "/", serveWelcome)
HTTP.@register(ROUTER, "GET", "/random", serveRandom)

Logging.global_logger(NullLogger())
HTTP.serve(ROUTER, Sockets.localhost, 8000)
