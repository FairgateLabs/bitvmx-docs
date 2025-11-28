# Client API

High-level guide for using the BitVMX Client library.

!!! tip "Detailed API Reference"
    For comprehensive API documentation with all types, functions, and modules, see the [**bitvmx_client Rust docs →**](../rust-api/bitvmx_client/index.html)

## Overview

The BitVMX Client (`bitvmx_client`) is the main entry point for interacting with BitVMX protocols and the Bitcoin blockchain. It provides a comprehensive CLI and programmatic interface for protocol execution, transaction management, and Bitcoin integration.

## Key Features

- **Protocol Execution**: Run BitVMX protocols (Cardinal, Union, etc.)
- **JSON RPC API**: Message-based communication over BitVMX broker
- **Transaction Management**: Dispatch, track, and verify Bitcoin transactions
- **Key Management**: Integrated cryptographic operations
- **SPV Proof Generation**: Create and verify SPV proofs

## Quick Start

### Installation

Add to your `Cargo.toml`:

```toml
[dependencies]
bitvmx-client = { git = "https://github.com/FairgateLabs/rust-bitvmx-client.git", branch = "v.0.0.2" }
```

### Basic Usage

```rust
use bitvmx_client::Client;

// Create a new client
let client = Client::new(config)?;

// Initialize a protocol
client.setup_protocol(protocol_config)?;

// Execute protocol steps
client.execute()?;
```

## Common Patterns

### Running Union Bridge Protocols

```rust
// Set up Union Bridge protocol
let protocol = client.setup_union_protocol(
    funding_tx,
    operator_keys,
)?;

// Execute peg-in flow
client.execute_pegin(protocol)?;
```

### Transaction Operations

```rust
// Dispatch a transaction
let txid = client.dispatch_transaction(tx)?;

// Query transaction status
let status = client.get_transaction_status(txid)?;

// Generate SPV proof
let proof = client.generate_spv_proof(txid)?;
```

### Key Management Integration

```rust
// Generate keys
let keypair = client.generate_keypair()?;

// Sign with MuSig2
let signature = client.musig2_sign(message, keypairs)?;
```

## API Messages

The client communicates via JSON RPC messages over the BitVMX broker. See [API Messages](messages.md) for details on:

- Program Management (Setup, Store Variables, Witness Data)
- Transaction Management (Queries, Dispatching, SPV Proofs)
- Subscriptions (Transaction updates, UTXO spending, RSK pegin)
- Wallet Operations (Balance, Addresses, Fund transfers)
- Key Management (Generation, Aggregation, Signing)
- Zero-Knowledge Proofs (Generation, Result retrieval)

## CLI Usage

The BitVMX client also provides a CLI:

```bash
# Run a protocol
bitvmx-client run --protocol union --config config.yaml

# Query status
bitvmx-client status --txid <txid>

# Generate keys
bitvmx-client keygen --output keys.json
```

## API Reference

For detailed API documentation:

- [**Complete Client API →**](../rust-api/bitvmx_client/index.html)
- [Client Module](../rust-api/bitvmx_client/client/index.html)
- [BitVMX Module](../rust-api/bitvmx_client/bitvmx/index.html)
- [Program Module](../rust-api/bitvmx_client/program/index.html)

## See Also

- [Protocol Builder API](protocol-builder-api.md) - Build transaction protocols
- [Key Manager API](key-manager-api.md) - Cryptographic operations
- [API Messages](messages.md) - RPC message formats
- [Your First Protocol Tutorial](../tutorials/first-protocol.md) - Step-by-step guide
- [Components Overview](../components/bitvmx-client.md) - Architecture details
