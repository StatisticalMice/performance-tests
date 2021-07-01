# performance-tests
Web based performance tests

https://genieframework.github.io/Genie.jl/dev/index.html  
https://docs.rs/crate/goose/0.11.2

## Rules

Performance tests are run with two configurations: 
- One thread without logging
- Multiple threads without logging (number of threads equal to virtual cores)

For troubleshooting testing, run with logging on the console.

Performance testing is run for:
- "/greeting"
- "/random"

## Configuring

To run with 8 threads, set this environment variable:
export JULIA_NUM_THREADS=8

To turn on logging to the console, create this environment variable:
export TURN_ON_LOGGING=anyvaluehere

Without these environment variables, Julia runs on a single thread, and web servers are configured to produce no logging.

To turn off these environment variables, use:
unset TURN_ON_LOGGING
unset JULIA_NUM_THREADS

## Run Genie web server with

Genie.jl will serve content on port 12000.

cd GenieApp
./bin/repl
up()

## Run plain Julia HTTP server with

HTTP.jl will serve content on port 11000.

cd HttpApp
julia --project=. http_server.jl

## Disturb the geese

Use port 11000 to test HTTP.jl. Use 12000 to test Genie.jl.

cd GooseAttack  
cargo run --release -- --host http://10.166.0.33:12000 --run-time 5m \
--users 50 --hatch-rate 5 --running-metrics 10 --verbose \
--requests-file ../attack_requests.csv --requests-format csv \
-R ../attack_report.html
