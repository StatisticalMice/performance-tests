# performance-tests
Web based performance tests

https://genieframework.github.io/Genie.jl/dev/index.html  
https://docs.rs/crate/goose/0.11.2

## Threading

export JULIA_NUM_THREADS=auto

## Run Julia web server with

cd GenieApp  
bin/repl  
julia> up()  

## Run plain Julia HTTP server with

julia --project=. http_server.jl  

## Python Flask App

https://flask.palletsprojects.com/en/2.0.x/  
You'll need flask installed.  
python FlaskApp/main.py  

## Run Goose Attack with Rust

cd GooseAttack  
cargo run --release -- --host http://127.0.0.1:8000 --run-time 2m --verbose --users 30 --hatch-rate 2 -R ../attack_report.html  
