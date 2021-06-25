# performance-tests
Web based performance tests

https://genieframework.github.io/Genie.jl/dev/index.html
https://docs.rs/crate/goose/0.11.2

## Run Julia web server with

cd GenieApp
bin/repl
julia> up()

## Run plain Julia HTTP server with

julia --project=. --threads=auto http_server.jl

## Run Goose Attack with Rust

cd GooseAttack
cargo run --release -- --host http://127.0.0.1:8000 -t 2m -v -u30 -r2 -R attack_report.html
