# Protocol Builder API

High-level guide for using the BitVMX Protocol Builder.

!!! tip "Detailed API Reference"
    For comprehensive API documentation with all types, functions, and modules, see the [**protocol_builder Rust docs →**](../rust-api/protocol_builder/index.html)

## Overview

The Protocol Builder (`protocol_builder`) is a Rust library for designing Bitcoin protocols as directed acyclic graphs (DAGs) of pre-signed transactions, enabling complex multi-step Bitcoin interactions.

## Key Features

- **DAG-Based Design**: Model protocols as graphs where transactions are nodes and spends are edges
- **Multi-Signature Support**: ECDSA, Schnorr, MuSig2, Winternitz one-time signatures
- **Automatic Fee Management**: Estimate sizes and apply fee margins automatically
- **Visualization**: Export protocols as Graphviz diagrams for auditing
- **CPFP Support**: Child-Pays-For-Parent for handling congestion

## Quick Start

### Installation

Add to your `Cargo.toml`:

```toml
[dependencies]
bitvmx-protocol-builder = { git = "https://github.com/FairgateLabs/rust-bitvmx-workspace.git", branch = "main" }
```

### Basic Usage

```rust
use protocol_builder::ProtocolBuilder;

// Create a new protocol builder
let mut builder = ProtocolBuilder::new();

// Add transactions to the protocol
let funding_tx = builder.add_transaction("funding", funding_tx_data)?;
let setup_tx = builder.add_transaction("setup", setup_tx_data)?;

// Link transactions (spending relationships)
builder.link(funding_tx, setup_tx, 0)?; // spend output 0 of funding in setup

// Build the protocol
let protocol = builder.build()?;
```

## Common Patterns

### Building a Payment Channel

```rust
// Create protocol
let mut protocol = ProtocolBuilder::new();

// Add funding transaction
let funding = protocol.add_external_utxo(outpoint)?;

// Add setup transaction (establishes channel)
let setup = protocol.add_transaction("setup")
    .add_input_from(funding, 0)?
    .add_taproot_output(channel_script, amount)?
    .build()?;

// Add commitment transactions
let commitment_a = protocol.add_transaction("commit_a")
    .add_input_from(setup, 0)?
    .add_output(alice_address, alice_amount)?
    .add_output(bob_address, bob_amount)?
    .build()?;

// Sign and finalize
protocol.sign_with_musig2(operator_keys)?;
let final_protocol = protocol.finalize()?;
```

### Automatic Fee Management

```rust
// Use AUTO_AMOUNT for automatic fee calculation
let tx = protocol.add_transaction("payment")
    .add_input_from(prev_tx, 0)?
    .add_output(recipient, AUTO_AMOUNT)? // Automatically deducts fees
    .with_fee_rate(10)? // 10 sat/vB
    .build()?;
```

### Visualizing Protocols

```rust
// Export protocol as Graphviz DOT
let dot = protocol.to_graphviz()?;
std::fs::write("protocol.dot", dot)?;

// Render with: dot -Tpng protocol.dot -o protocol.png
```

## Transaction Types

The builder supports various transaction types:

- **SegWit (P2WPKH)**: Traditional segregated witness
- **Taproot (P2TR)**: Key path and script path spending
- **MuSig2**: Aggregated signatures for multiple parties
- **Winternitz OTS**: One-time signatures for BitVMX challenge-response

## API Reference

For detailed API documentation:

- [**Complete Protocol Builder API →**](../rust-api/protocol_builder/index.html)
- [Builder Module](../rust-api/protocol_builder/builder/index.html)
- [Transaction Types](../rust-api/protocol_builder/transaction/index.html)
- [Graph Operations](../rust-api/protocol_builder/graph/index.html)

## See Also

- [Building Protocols Guide](../developer-guide/building-protocols.md) - Comprehensive tutorial
- [Client API](client-api.md) - Protocol execution
- [Key Manager API](key-manager-api.md) - Signature generation
- [Payment Channels Tutorial](../tutorials/payment-channels.md) - Practical example
- [Components Overview](../components/protocol-builder.md) - Architecture details
