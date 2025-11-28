# Broker API

High-level guide for using the BitVMX Broker service.

!!! tip "Detailed API Reference"
    For comprehensive API documentation with all types, functions, and modules, see the [**bitvmx_broker Rust docs →**](../rust-api/bitvmx_broker/index.html)

## Overview

The BitVMX Broker (`bitvmx_broker`) is a message broker service that handles identity, routing, and message transport between operators in the BitVMX network.

## Key Features

- **TLS Authentication**: Certificate validation via public key hash
- **Message Routing**: Configurable routing tables and allowlists
- **Dual-Channel API**: Bidirectional communication support
- **Coordination**: Internal sub-component and cross-operator messaging

## Quick Start

### Installation

Add to your `Cargo.toml`:

```toml
[dependencies]
bitvmx-broker = { git = "https://github.com/FairgateLabs/rust-bitvmx-workspace.git", branch = "main" }
```

### Basic Usage

```rust
use bitvmx_broker::{BrokerClient, BrokerConfig};

// Initialize broker client
let config = BrokerConfig::from_file("config.yaml")?;
let client = BrokerClient::new(config)?;

// Send a message
client.send("peer_id", message_bytes)?;

// Receive messages
let message = client.receive()?;
```

## Common Patterns

### Configuring Routing

```yaml
# config.yaml
allowlist:
  - peer_id: "abc123"
    address: "10.0.0.1"

routing_table:
  - source: "peer1"
    destination: "peer2"
```

### Message Handling

```rust
// Subscribe to messages
client.subscribe("topic", |msg| {
    println!("Received: {:?}", msg);
})?;
```

## API Reference

For detailed API documentation:

- [**Complete Broker API →**](../rust-api/bitvmx_broker/index.html)
- [Broker Client](../rust-api/bitvmx_broker/index.html#structs)
- [Configuration](../rust-api/bitvmx_broker/index.html#modules)

## See Also

- [Operator Communication](../components/broker.md) - Architecture overview
- [Developer Guide](../developer-guide/index.md) - Integration patterns
