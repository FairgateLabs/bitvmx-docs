# Transaction Monitor API

High-level guide for using the BitVMX Transaction Monitor.

!!! tip "Detailed API Reference"
    For comprehensive API documentation with all types, functions, and modules, see the [**bitvmx_transaction_monitor Rust docs →**](../rust-api/bitvmx_transaction_monitor/index.html)

## Overview

The BitVMX Transaction Monitor (`bitvmx_transaction_monitor`) is a real-time tracking system that connects to an Indexer and persistently tracks UTXOs and blocks, emitting status updates when transactions reach confirmation thresholds.

## Key Features

- **Real-Time Tracking**: Continuous monitoring of UTXOs and transactions
- **Confirmation Thresholds**: Configurable notification triggers
- **Persistent State**: Maintains monitoring state across restarts
- **Event Notifications**: Callback-based status updates

## Quick Start

### Installation

Add to your `Cargo.toml`:

```toml
[dependencies]
bitvmx-transaction-monitor = { git = "https://github.com/FairgateLabs/rust-bitvmx-workspace.git", branch = "main" }
```

### Basic Usage

```rust
use bitvmx_transaction_monitor::TransactionMonitor;

// Initialize monitor
let monitor = TransactionMonitor::new(config)?;

// Track a UTXO
monitor.track_utxo(outpoint, |status| {
    println!("UTXO status: {:?}", status);
})?;

// Track a transaction
monitor.track_tx(txid, 6, |confirmations| {
    println!("Confirmations: {}", confirmations);
})?;
```

## Common Patterns

### Monitoring UTXOs

```rust
// Monitor UTXO until spent
monitor.track_until_spent(outpoint, |spent_in| {
    println!("UTXO spent in tx: {}", spent_in);
})?;

// Check UTXO status
let status = monitor.get_utxo_status(outpoint)?;
```

### Transaction Confirmations

```rust
// Wait for specific confirmation count
monitor.wait_for_confirmations(txid, 6, |confirmations| {
    if confirmations >= 6 {
        println!("Transaction confirmed!");
    }
})?;
```

### RSK Pegin Monitoring

```rust
// Monitor RSK pegin transactions
monitor.monitor_rsk_pegin(address, |pegin_event| {
    println!("Pegin detected: {:?}", pegin_event);
})?;
```

## API Reference

For detailed API documentation:

- [**Complete Transaction Monitor API →**](../rust-api/bitvmx_transaction_monitor/index.html)
- [Monitor Module](../rust-api/bitvmx_transaction_monitor/index.html#modules)
- [Event Types](../rust-api/bitvmx_transaction_monitor/index.html#structs)

## See Also

- [Coordinator API](coordinator-api.md) - Transaction dispatch
- [Indexer API](indexer-api.md) - Blockchain indexing
- [Components Overview](../components/transaction-monitor.md) - Architecture
