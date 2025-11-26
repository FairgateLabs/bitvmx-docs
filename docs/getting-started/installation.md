# Installation

This guide walks you through installing BitVMX and its components.

## BitVMX Workspace

The recommended way to work with BitVMX is using the workspace that includes all components.

### Clone the Workspace

```bash
git clone --recurse-submodules https://github.com/FairgateLabs/rust-bitvmx-workspace.git
cd rust-bitvmx-workspace
```

If you already cloned without submodules:

```bash
git submodule init
git submodule update --remote --checkout
```

### Build the Workspace

```bash
cargo build --release
```

This will build all components. The initial build may take 15-30 minutes depending on your system.

## Individual Components

You can also install individual components:

### BitVMX Client

```bash
git clone https://github.com/FairgateLabs/rust-bitvmx-client.git
cd rust-bitvmx-client
cargo build --release
```

### BitVMX CPU

```bash
cd BitVMX-CPU
cargo build --release
```

## Docker Installation

For a containerized environment:

```bash
git clone https://github.com/FairgateLabs/docker-bitvmx.git
cd docker-bitvmx
docker-compose up -d
```

## Verify Installation

Test that BitVMX is working:

```bash
cargo test --release
```

Run a simple example:

```bash
cargo run --release --example hello
```

## Troubleshooting

### Build Errors

If you encounter build errors:

1. Ensure Rust is up to date: `rustup update`
2. Clean and rebuild: `cargo clean && cargo build --release`
3. Check [Troubleshooting Guide](../developer-guide/troubleshooting.md)

### Dependency Issues

Install missing system dependencies:

=== "Ubuntu/Debian"
    ```bash
    sudo apt install build-essential pkg-config libssl-dev
    ```

=== "macOS"
    ```bash
    brew install openssl pkg-config
    ```

## Next Steps

Now that BitVMX is installed, proceed to the [Quick Start](quick-start.md) guide.
