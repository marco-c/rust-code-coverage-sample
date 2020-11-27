#!/bin/sh

rm -rf ./target *.prof*

export RUSTFLAGS="-Zinstrument-coverage"

cargo build

cargo run

grcov . --binary-path ./target/debug -s . -t html --branch --ignore-not-existing -o ./target/debug/coverage/
