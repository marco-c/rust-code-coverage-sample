#!/bin/sh

rm -rf ./target

CARGO_INCREMENTAL=0 RUSTDOCFLAGS="-Cpanic=abort" RUSTFLAGS="-Zprofile -Ccodegen-units=1 -Copt-level=0 -Clink-dead-code -Coverflow-checks=off -Zpanic_abort_tests -Cpanic=abort" cargo build
./target/debug/rust-code-coverage-sample
grcov . -s . -t html --llvm --branch --ignore-not-existing -o ./target/debug/coverage/
