#!/bin/sh

cd GooseAttack  
cargo run --release -- --host http://127.0.0.1:8000 --run-time 5m \
--users 100 --hatch-rate 5 --running-metrics 10 --verbose \
--requests-file attack_requests.csv --requests-format csv \
-R ../attack_report.html
