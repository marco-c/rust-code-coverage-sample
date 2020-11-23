N.B.: At the moment, the nightly channel of Rust is required.

First of all, install grcov
```sh
cargo install grcov
```

Second, install the llvm-tools Rust component (`llvm-tools-preview` for now, it might become `llvm-tools` soon):
```sh
rustup component add llvm-tools-preview
```

# Generate source-based coverage

```sh
rm -rf ./target *.prof*

# Export the flags needed to instrument the program to collect code coverage.
export RUSTFLAGS="-Zinstrument-coverage"

# Build the program
cargo build

# Run the program (you can replace this with `cargo test` if you want to collect code coverage for your tests).
cargo run

# Generate a HTML report in the coverage/ directory.
grcov . --binary-path ./target/debug/rust-code-coverage-sample -s . -t html --branch --ignore-not-existing -o ./coverage/

# Generate a LCOV report and upload it to codecov.io.
grcov . --binary-path ./target/debug/rust-code-coverage-sample -s . -t lcov --branch --ignore-not-existing -o ./lcov.info
bash <(curl -s https://codecov.io/bash) -f lcov.info
```

# Generate gcov-based coverage

```sh
rm -rf ./target

# Export the flags needed to instrument the program to collect code coverage, and the flags needed to work around
# some Rust features that are incompatible with gcov-based instrumentation.
export CARGO_INCREMENTAL=0
export RUSTDOCFLAGS="-Cpanic=abort"
export RUSTFLAGS="-Zprofile -Ccodegen-units=1 -Copt-level=0 -Clink-dead-code -Coverflow-checks=off -Zpanic_abort_tests -Cpanic=abort"

# Build the program
cargo build

# Run the program (you can replace this with `cargo test` if you want to collect code coverage for your tests).
cargo run

# Generate a HTML report in the coverage/ directory.
grcov . --llvm -s . -t html --branch --ignore-not-existing -o ./coverage/

# Generate a LCOV report and upload it to codecov.io.
grcov . --llvm -s . -t lcov --branch --ignore-not-existing -o ./lcov.info
bash <(curl -s https://codecov.io/bash) -f lcov.info
```
