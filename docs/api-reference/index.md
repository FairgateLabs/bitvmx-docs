# API Reference

Welcome to the BitVMX API Reference documentation. This section provides comprehensive documentation for all BitVMX APIs and interfaces.

## Rust API Documentation

Comprehensive Rust API documentation for all BitVMX crates is available:

[Browse Rust API Documentation →](../rust-api/index.html){.md-button .md-button--primary}

### Available Crates

<div class="grid cards" markdown>

-   :material-application-cog:{ .lg .middle } **bitvmx_client**

    ---

    Main BitVMX client library for interacting with BitVMX protocols and the Bitcoin blockchain.

    [:octicons-arrow-right-24: Rust API](../rust-api/bitvmx_client/index.html)
    [:octicons-book-24: Guide](client-api.md)

-   :material-graph:{ .lg .middle } **protocol_builder**

    ---

    Build and manage DAGs of pre-signed Bitcoin transactions for protocol design.

    [:octicons-arrow-right-24: Rust API](../rust-api/protocol_builder/index.html)
    [:octicons-book-24: Guide](protocol-builder-api.md)

-   :material-key:{ .lg .middle } **key_manager**

    ---

    Manage cryptographic keys for BitVMX protocol transactions with multiple signature schemes.

    [:octicons-arrow-right-24: Rust API](../rust-api/key_manager/index.html)
    [:octicons-book-24: Guide](key-manager-api.md)

-   :material-database:{ .lg .middle } **storage_backend**

    ---

    RocksDB-based encrypted storage backend for persisting BitVMX state.

    [:octicons-arrow-right-24: Rust API](../rust-api/storage_backend/index.html)
    [:octicons-book-24: Guide](storage-api.md)

-   :material-message-processing:{ .lg .middle } **bitvmx_broker**

    ---

    Message broker service for coordinating communication between operators.

    [:octicons-arrow-right-24: Rust API](../rust-api/bitvmx_broker/index.html)
    [:octicons-book-24: Guide](broker-api.md)

-   :material-traffic-cone:{ .lg .middle } **bitcoin_coordinator**

    ---

    Central orchestration system for Bitcoin transaction management and monitoring.

    [:octicons-arrow-right-24: Rust API](../rust-api/bitcoin_coordinator/index.html)
    [:octicons-book-24: Guide](coordinator-api.md)

-   :material-database-search:{ .lg .middle } **bitcoin_indexer**

    ---

    Fast, persistent blockchain indexing solution for Bitcoin Core integration.

    [:octicons-arrow-right-24: Rust API](../rust-api/bitcoin_indexer/index.html)
    [:octicons-book-24: Guide](indexer-api.md)

-   :material-monitor-eye:{ .lg .middle } **bitvmx_transaction_monitor**

    ---

    Real-time tracking system for monitoring UTXOs and Bitcoin transactions.

    [:octicons-arrow-right-24: Rust API](../rust-api/bitvmx_transaction_monitor/index.html)
    [:octicons-book-24: Guide](transaction-monitor-api.md)

-   :material-wallet:{ .lg .middle } **bitvmx_wallet**

    ---

    Wallet management for handling Bitcoin transactions and key derivation.

    [:octicons-arrow-right-24: Rust API](../rust-api/bitvmx_wallet/index.html)
    [:octicons-book-24: Guide](wallet-api.md)

-   :material-cog:{ .lg .middle } **bitvmx_settings**

    ---

    Configuration management system for BitVMX services with environment awareness.

    [:octicons-arrow-right-24: Rust API](../rust-api/bitvmx_settings/index.html)
    [:octicons-book-24: Guide](settings-api.md)

</div>

## High-Level Guides

For conceptual overviews and usage examples, explore the following guides:

- **[Client API Guide](client-api.md)** - High-level client usage patterns and workflows
- **[Protocol Builder Guide](protocol-builder-api.md)** - Building protocols step-by-step
- **[Key Manager Guide](key-manager-api.md)** - Key management workflows and best practices
- **[Storage API Guide](storage-api.md)** - Working with the storage backend
- **[Broker API Guide](broker-api.md)** - Message broker integration
- **[Coordinator API Guide](coordinator-api.md)** - Transaction coordination patterns
- **[Indexer API Guide](indexer-api.md)** - Blockchain indexing strategies
- **[Transaction Monitor Guide](transaction-monitor-api.md)** - Monitoring Bitcoin transactions
- **[Wallet API Guide](wallet-api.md)** - Wallet management and operations
- **[Settings API Guide](settings-api.md)** - Configuration management
- **[API Messages](messages.md)** - Common message formats and protocols

## Quick Links

- [Developer Guide](../developer-guide/index.md) - Development setup and workflows
- [Components Overview](../components/index.md) - System architecture
- [Tutorials](../tutorials/index.md) - Step-by-step tutorials
- [Technical Reference](../technical-reference/index.md) - In-depth technical details

## Documentation Structure

The API documentation is organized into two complementary sections:

1. **Rust API Documentation** (generated from code) - Detailed technical reference with type signatures, function definitions, and implementation details
2. **API Guides** (curated content) - High-level conceptual guides with usage examples, common patterns, and best practices

Use the Rust API docs when you need precise technical details about types and functions. Use the guides when you're learning concepts or looking for usage examples.
