# Coordinator API

High-level guide for using the Bitcoin Coordinator.

!!! tip "Detailed API Reference"
    For comprehensive API documentation with all types, functions, and modules, see the [**bitcoin_coordinator Rust docs →**](../rust-api/bitcoin_coordinator/index.html)

## Overview

The Bitcoin Coordinator (`bitcoin_coordinator`) is the central orchestration system for Bitcoin transaction management, dispatching, confirmation tracking, and applying fee speedups (CPFP/RBF) when needed.

## Key Features

- **Transaction Dispatch**: Submit and track Bitcoin transactions
- **Confirmation Monitoring**: Track transaction confirmations
- **Fee Management**: Automatic CPFP and RBF speedups
- **Persistent State**: Maintains state across restarts

## Quick Start

### Installation

Add to your `Cargo.toml`:

```toml
[dependencies]
bitcoin-coordinator = { git = "https://github.com/FairgateLabs/rust-bitvmx-workspace.git", branch = "main" }
```

### Basic Usage

```rust
use bitcoin_coordinator::Coordinator;

// Initialize coordinator
let coordinator = Coordinator::new(config)?;

// Dispatch a transaction
let txid = coordinator.dispatch_tx(transaction)?;

// Track confirmations
let confirmations = coordinator.get_confirmations(txid)?;
```

## Common Patterns

### Transaction Monitoring

```rust
// Monitor transaction until confirmed
coordinator.wait_for_confirmations(txid, 6).await?;

// Check if transaction needs speedup
if coordinator.needs_speedup(txid)? {
    coordinator.apply_rbf(txid)?;
}
```

### Batch Operations

```rust
// Dispatch multiple transactions
let txids = coordinator.dispatch_batch(transactions)?;

// Monitor batch completion
coordinator.wait_for_batch(txids, 6).await?;
```

## API Reference

For detailed API documentation:

- [**Complete Coordinator API →**](../rust-api/bitcoin_coordinator/index.html)
- [Coordinator Module](../rust-api/bitcoin_coordinator/index.html#modules)
- [Transaction Types](../rust-api/bitcoin_coordinator/index.html#structs)

## See Also

- [Transaction Monitor API](transaction-monitor-api.md) - UTXO tracking
- [Indexer API](indexer-api.md) - Blockchain indexing
- [Components Overview](../components/coordinator.md) - Architecture
