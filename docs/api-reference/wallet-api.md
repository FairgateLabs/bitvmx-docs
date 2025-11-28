# Wallet API

High-level guide for using the BitVMX Wallet.

!!! tip "Detailed API Reference"
    For comprehensive API documentation with all types, functions, and modules, see the [**bitvmx_wallet Rust docs →**](../rust-api/bitvmx_wallet/index.html)

## Overview

The BitVMX Wallet (`bitvmx_wallet`) provides wallet management for handling Bitcoin transactions and hierarchical key derivation.

## Key Features

- **HD Wallet Support**: BIP32/BIP44 hierarchical deterministic wallets
- **Transaction Building**: Construct and sign Bitcoin transactions
- **Address Generation**: Derive addresses from seeds
- **UTXO Management**: Track and manage unspent outputs

## Quick Start

### Installation

Add to your `Cargo.toml`:

```toml
[dependencies]
bitvmx-wallet = { git = "https://github.com/FairgateLabs/rust-bitvmx-workspace.git", branch = "main" }
```

### Basic Usage

```rust
use bitvmx_wallet::Wallet;

// Initialize wallet from seed
let wallet = Wallet::from_seed(seed_phrase)?;

// Generate a receiving address
let address = wallet.get_new_address()?;

// Get balance
let balance = wallet.get_balance()?;
```

## Common Patterns

### Transaction Creation

```rust
// Build a transaction
let tx = wallet.build_tx()
    .add_recipient(recipient_address, amount)?
    .with_fee_rate(fee_rate)?
    .build()?;

// Sign the transaction
let signed_tx = wallet.sign_tx(tx)?;

// Broadcast
wallet.broadcast(signed_tx)?;
```

### Key Derivation

```rust
// Derive keys using BIP44 path
let key = wallet.derive_key("m/44'/0'/0'/0/0")?;

// Get extended public key
let xpub = wallet.get_xpub()?;
```

## API Reference

For detailed API documentation:

- [**Complete Wallet API →**](../rust-api/bitvmx_wallet/index.html)
- [Wallet Module](../rust-api/bitvmx_wallet/index.html#modules)
- [Transaction Types](../rust-api/bitvmx_wallet/index.html#structs)

## See Also

- [Key Manager API](key-manager-api.md) - Cryptographic key management
- [Transaction Monitor API](transaction-monitor-api.md) - Track transactions
- [Components Overview](../components/wallet.md) - Architecture details
