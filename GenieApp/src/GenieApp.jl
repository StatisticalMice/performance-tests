module GenieApp

using Genie, Logging, LoggingExtras

function main()
  Base.eval(Main, :(const UserApp = GenieApp))

  Genie.genie(; context = @__MODULE__)

  Base.eval(Main, :(const Genie = GenieApp.Genie))
  Base.eval(Main, :(using Genie))
end

end
