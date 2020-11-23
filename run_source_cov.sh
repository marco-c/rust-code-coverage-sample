#!/bin/sh

rm -rf ./target *.prof* *.info

export RUSTFLAGS="-Zinstrument-coverage -Cprefer-dynamic"
export LD_LIBRARY_PATH="/home/marco/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/"

cargo build
./target/debug/rust-code-coverage-sample
# llvm-profdata merge -sparse default.profraw -o default.profdata
# llvm-cov export --Xdemangler=rustfilt target/debug/rust-code-coverage-sample --instr-profile=default.profdata --format lcov > output.info
grcov . --binary-path ./target/debug/rust-code-coverage-sample -s . -t html --llvm --branch --ignore-not-existing -o ./target/debug/coverage/
