using HTTP: @register
using HTTP, Sockets, JSON3, Logging
using HTTP.URIs: queryparams, URI

const ROUTER = HTTP.Router()

function serveWelcome(req::HTTP.Request)
    return HTTP.Response(200, "welcome.html")
end

if haskey(ENV, "TURN_ON_LOGGING")
    const GREETING = "Welcome to HTTP.jl! This site is served by Julia $(Base.VERSION) with $(Threads.nthreads()) threads. Logging is turned on."
else
    const GREETING = "Welcome to HTTP.jl! This site is served by Julia $(Base.VERSION) with $(Threads.nthreads()) threads. Logging is turned off."
end

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

if !haskey(ENV, "TURN_ON_LOGGING")
    Logging.global_logger(NullLogger())
end

HTTP.serve(ROUTER, Sockets.localhost, 11000)
