# performance-tests
Web based performance tests

https://genieframework.github.io/Genie.jl/dev/index.html  
https://docs.rs/crate/goose/0.11.2

## Rules

Performance tests are run with two configurations: 
- One thread
- Multiple threads, number of threads equal to virtual cores

Logging to the console is turned on. Logging to a file is turned off.
This is for troubleshooting purposes.

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

HTTP.jl
=======
cargo run --release -- --host http://127.0.0.1:11000 --run-time 5m \
--users 1000 --hatch-rate 100 --running-metrics 15 --verbose \
-R reports/attack_report-http_e2_standard_4_threads_N.html

Genie.jl
========
cargo run --release -- --host http://127.0.0.1:12000 --run-time 5m \
--users 1000 --hatch-rate 100 --running-metrics 15 --verbose \
-R reports/attack_report-genie_e2_standard_4_threads_N.html

Copying the reports from GCP:
gcloud compute scp --recurse  perftest-geese-vm-2f670eabed7796cd:/home/arihuttunen/performance-tests/GooseAttack/reports/ .
