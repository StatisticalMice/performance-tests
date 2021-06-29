using HTTP: @register
using HTTP, Sockets, JSON3, Logging
using HTTP.URIs: queryparams, URI

const ROUTER = HTTP.Router()

function serveWelcome(req::HTTP.Request)
    return HTTP.Response(200, "welcome.html")
end

const GREETING = "Welcome to Genie! This site is served by Julia $(Base.VERSION) with $(Threads.nthreads()) threads."

function serveGreeting(req::HTTP.Request)
    return HTTP.Response(200, GREETING)
end

function serveRandom(req::HTTP.Request)
    p = get(queryparams(URI(req.target)), "num", "1")
    num = tryparse(Int32, p)
    if (num === nothing || num < 1) 
        num = 1
    end

    return HTTP.Response(200, JSON3.write(rand(Int, num)))
end

HTTP.@register(ROUTER, "GET", "/", serveWelcome)
HTTP.@register(ROUTER, "GET", "/greeting", serveGreeting)
HTTP.@register(ROUTER, "GET", "/random", serveRandom)

Logging.global_logger(NullLogger())
HTTP.serve(ROUTER, Sockets.localhost, 8000)
