# Indexer API

High-level guide for using the Bitcoin Indexer.

!!! tip "Detailed API Reference"
    For comprehensive API documentation with all types, functions, and modules, see the [**bitcoin_indexer Rust docs →**](../rust-api/bitcoin_indexer/index.html)

## Overview

The Bitcoin Indexer (`bitcoin_indexer`) is a fast, persistent blockchain indexing solution that connects to Bitcoin Core and stores block and transaction IDs into RocksDB for efficient historical access.

## Key Features

- **Fast Indexing**: Deterministic, block-by-block processing
- **Persistent Storage**: RocksDB-based storage for quick lookups
- **Configurable Start Height**: Partial syncs from specific block heights
- **Efficient Queries**: Quick access to historical blockchain data

## Quick Start

### Installation

Add to your `Cargo.toml`:

```toml
[dependencies]
bitcoin-indexer = { git = "https://github.com/FairgateLabs/rust-bitvmx-workspace.git", branch = "main" }
```

### Basic Usage

```rust
use bitcoin_indexer::Indexer;

// Initialize indexer
let indexer = Indexer::new(config)?;

// Start indexing from a specific height
indexer.sync_from_height(700000)?;

// Query indexed data
let tx = indexer.get_transaction(txid)?;
let block = indexer.get_block(block_hash)?;
```

## Common Patterns

### Synchronization

```rust
// Sync to tip of blockchain
indexer.sync_to_tip()?;

// Get current sync status
let status = indexer.sync_status()?;
println!("Height: {}, Synced: {}", status.height, status.is_synced);
```

### Querying

```rust
// Get transaction by ID
let tx = indexer.get_tx_by_id(txid)?;

// Get block by height
let block = indexer.get_block_at_height(750000)?;

// Check if transaction exists
if indexer.has_tx(txid)? {
    println!("Transaction found");
}
```

## API Reference

For detailed API documentation:

- [**Complete Indexer API →**](../rust-api/bitcoin_indexer/index.html)
- [Indexer Module](../rust-api/bitcoin_indexer/index.html#modules)
- [Query Types](../rust-api/bitcoin_indexer/index.html#structs)

## See Also

- [Coordinator API](coordinator-api.md) - Transaction management
- [Transaction Monitor API](transaction-monitor-api.md) - Real-time monitoring
- [Components Overview](../components/indexer.md) - Architecture details
