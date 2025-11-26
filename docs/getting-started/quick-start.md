# Quick Start

Get started with BitVMX in minutes! This guide will walk you through running your first BitVMX example.

## Prerequisites

Ensure you have completed the [Installation](installation.md) guide.

## Running Your First Example

BitVMX includes several examples to help you get started. Let's run the Union Bridge committee setup example.

### 1. Start a Bitcoin Node

First, start a local Bitcoin regtest node:

```bash
cargo run --release --example union setup_bitcoin_node
```

This starts a Bitcoin node in regtest mode for testing.

### 2. Start BitVMX Instance

In a new terminal, start a BitVMX instance with default operators:

```bash
cargo run --release all
```

Or start fresh (clearing previous data):

```bash
rm -rf /tmp/regtest/
cargo run --release all --fresh
```

### 3. Run the Committee Flow

In another terminal, run the committee setup:

```bash
cargo run --release --example union committee
```

This will:

1. Create a committee of operators
2. Generate aggregated keys
3. Set up the protocol structure
4. Display the committee information

## What Just Happened?

You just:

- ✅ Started a local Bitcoin network
- ✅ Launched BitVMX operators
- ✅ Created a multi-party committee
- ✅ Generated cryptographic keys using MuSig2

## Next Steps

### Explore More Examples

Try other Union Bridge examples:

```bash
# Request a peg-in
cargo run --release --example union request_pegin

# Accept a peg-in
cargo run --release --example union accept_pegin

# Test advance funds
cargo run --release --example union advance_funds
```

### Learn Core Concepts

Now that you've seen BitVMX in action, learn how it works:

- [Architecture Overview](../core-concepts/architecture.md)
- [Challenge-Response Protocol](../core-concepts/challenge-response.md)
- [Union Bridge Introduction](../union-bridge/introduction.md)

### Build Your Own

Ready to build? Check out:

- [Your First Protocol Tutorial](../tutorials/first-protocol.md)
- [Developer Guide](../developer-guide/index.md)
- [API Reference](../api-reference/index.md)

## Troubleshooting

### Port Already in Use

If you see "address already in use" errors:

```bash
# Kill existing processes
pkill -f bitvmx-client
pkill -f bitcoind
```

### Connection Errors

Ensure all services are running:

```bash
# Check Bitcoin node
bitcoin-cli -regtest getblockchaininfo

# Check BitVMX services
ps aux | grep bitvmx
```

For more help, see the [Troubleshooting Guide](../developer-guide/troubleshooting.md).
