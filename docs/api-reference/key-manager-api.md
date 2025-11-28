# Key Manager API

High-level guide for using the BitVMX Key Manager.

!!! tip "Detailed API Reference"
    For comprehensive API documentation with all types, functions, and modules, see the [**key_manager Rust docs →**](../rust-api/key_manager/index.html)

## Overview

The Key Manager (`key_manager`) is a Rust library for cryptographic key management supporting multiple signature schemes including ECDSA, Schnorr, Winternitz one-time signatures, and MuSig2.

## Key Features

- **Multiple Signature Schemes**: ECDSA, Schnorr, Winternitz OTS, MuSig2
- **Secure Storage**: Keys are encrypted and persisted via Storage Backend
- **Hierarchical Key Derivation**: BIP32/BIP44 support
- **Taproot Support**: Full support for Taproot tweaks (key and script paths)
- **Key Import/Export**: Flexible key management workflows

## Quick Start

### Installation

Add to your `Cargo.toml`:

```toml
[dependencies]
bitvmx-key-manager = { git = "https://github.com/FairgateLabs/rust-bitvmx-workspace.git", branch = "main" }
```

### Basic Usage

```rust
use key_manager::KeyManager;

// Initialize key manager
let key_manager = KeyManager::new(storage)?;

// Generate a new key
let keypair = key_manager.generate_keypair()?;

// Store the key
key_manager.store_key("my_key", keypair)?;

// Load a key
let loaded_key = key_manager.load_key("my_key")?;
```

## Common Patterns

### ECDSA Signing

```rust
// Generate ECDSA key
let ecdsa_key = key_manager.generate_ecdsa()?;

// Sign a message
let signature = key_manager.sign_ecdsa(message, &ecdsa_key)?;

// Verify signature
let valid = key_manager.verify_ecdsa(message, &signature, &ecdsa_key.public)?;
```

### Schnorr Signatures

```rust
// Generate Schnorr key
let schnorr_key = key_manager.generate_schnorr()?;

// Sign with Schnorr
let signature = key_manager.sign_schnorr(message, &schnorr_key)?;

// Verify
let valid = key_manager.verify_schnorr(message, &signature, &schnorr_key.public)?;
```

### MuSig2 (Multi-Party Signatures)

```rust
// Generate keys for multiple parties
let key1 = key_manager.generate_schnorr()?;
let key2 = key_manager.generate_schnorr()?;

// Aggregate public keys
let agg_key = key_manager.musig2_aggregate_keys(vec![&key1.public, &key2.public])?;

// Create nonces
let nonce1 = key_manager.musig2_nonce_gen(&key1)?;
let nonce2 = key_manager.musig2_nonce_gen(&key2)?;

// Sign (each party)
let partial_sig1 = key_manager.musig2_partial_sign(message, &key1, &nonce1, vec![&nonce2])?;
let partial_sig2 = key_manager.musig2_partial_sign(message, &key2, &nonce2, vec![&nonce1])?;

// Aggregate signatures
let final_sig = key_manager.musig2_aggregate_signatures(vec![&partial_sig1, &partial_sig2])?;
```

### Winternitz One-Time Signatures

```rust
// Generate Winternitz keypair
let wots_key = key_manager.generate_winternitz()?;

// Sign (can only sign once!)
let wots_signature = key_manager.sign_winternitz(message, &wots_key)?;

// Verify
let valid = key_manager.verify_winternitz(message, &wots_signature, &wots_key.public)?;
```

### Taproot Support

```rust
// Generate Taproot key
let internal_key = key_manager.generate_schnorr()?;

// Apply script path tweak
let script_tree = /* build script tree */;
let tweaked_key = key_manager.taproot_tweak_key(&internal_key, script_tree)?;

// Sign with tweaked key (key path spend)
let signature = key_manager.sign_taproot_keypath(message, &tweaked_key)?;
```

## Key Storage

Keys are automatically encrypted and stored via the Storage Backend:

```rust
// Store a key with a name
key_manager.store_key("operator_key", keypair)?;

// List all stored keys
let keys = key_manager.list_keys()?;

// Delete a key
key_manager.delete_key("old_key")?;
```

## API Reference

For detailed API documentation:

- [**Complete Key Manager API →**](../rust-api/key_manager/index.html)
- [Key Generation](../rust-api/key_manager/index.html#functions)
- [Signature Schemes](../rust-api/key_manager/index.html#modules)
- [Storage Integration](../rust-api/key_manager/storage/index.html)

## See Also

- [Client API](client-api.md) - Key usage in protocols
- [Protocol Builder API](protocol-builder-api.md) - Signing transactions
- [Storage Backend API](storage-api.md) - Key persistence
- [Components Overview](../components/key-manager.md) - Architecture details
