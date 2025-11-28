# Storage Backend API

High-level guide for using the BitVMX Storage Backend library.

!!! tip "Detailed API Reference"
    For comprehensive API documentation with all types, functions, and modules, see the [**storage_backend Rust docs →**](../rust-api/storage_backend/index.html)

## Overview

The BitVMX Storage Backend (`storage_backend`) is a RocksDB-based encrypted storage solution that provides transactional key-value storage for persisting BitVMX state across the entire stack.

## Key Features

- **Encrypted Storage**: All data is encrypted at rest
- **Transaction Support**: Full ACID compliance with begin, commit, and rollback operations
- **Prefix Queries**: Efficiently filter by key prefixes for indexing and metadata
- **High Performance**: Built on RocksDB for fast, persistent storage

## Quick Start

### Installation

Add to your `Cargo.toml`:

```toml
[dependencies]
rust-bitvmx-storage-backend = { git = "https://github.com/FairgateLabs/rust-bitvmx-workspace.git", branch = "main" }
```

### Basic Usage

```rust
use storage_backend::StorageBackend;

// Initialize storage
let storage = StorageBackend::new("/path/to/db")?;

// Write data
storage.put(b"key", b"value")?;

// Read data
let value = storage.get(b"key")?;

// Delete data
storage.delete(b"key")?;
```

## Common Patterns

### Working with Transactions

```rust
// Begin a transaction
let txn = storage.begin()?;

// Perform multiple operations
txn.put(b"key1", b"value1")?;
txn.put(b"key2", b"value2")?;

// Commit the transaction
txn.commit()?;
```

### Prefix Queries

```rust
// Query all keys with a specific prefix
let results = storage.get_by_prefix(b"user:")?;

for (key, value) in results {
    println!("{:?} = {:?}", key, value);
}
```

## API Reference

For detailed API documentation:

- [**Complete Storage Backend API →**](../rust-api/storage_backend/index.html)
- [Storage Modules](../rust-api/storage_backend/index.html#modules)
- [Core Types](../rust-api/storage_backend/index.html#structs)

## See Also

- [Settings API](settings-api.md) - Configuration management
- [Key Manager API](key-manager-api.md) - Key storage integration
- [Components Overview](../components/storage.md) - Architecture details
