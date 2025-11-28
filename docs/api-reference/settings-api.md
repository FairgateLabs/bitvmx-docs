# Settings API

High-level guide for using the BitVMX Settings library.

!!! tip "Detailed API Reference"
    For comprehensive API documentation with all types, functions, and modules, see the [**bitvmx_settings Rust docs →**](../rust-api/bitvmx_settings/index.html)

## Overview

The BitVMX Settings (`bitvmx_settings`) is a lightweight configuration management tool that loads configurations based on environment awareness and provides standardized runtime settings across BitVMX services.

## Key Features

- **Environment Awareness**: Loads configurations based on `BITVMX_ENV` variable
- **YAML Format**: Human-readable configuration files
- **CLI Overrides**: Override settings via command-line flags
- **Validation**: Type-safe configuration with validation

## Quick Start

### Installation

Add to your `Cargo.toml`:

```toml
[dependencies]
bitvmx-settings = { git = "https://github.com/FairgateLabs/rust-bitvmx-workspace.git", branch = "main" }
```

### Basic Usage

```rust
use bitvmx_settings::Settings;

// Load settings (uses BITVMX_ENV to determine environment)
let settings = Settings::load()?;

// Access configuration values
let bitcoin_rpc_url = settings.bitcoin.rpc_url;
let network = settings.network;
```

## Common Patterns

### Configuration Files

```yaml
# config/development.yaml
network: regtest
bitcoin:
  rpc_url: "http://localhost:18443"
  rpc_user: "user"
  rpc_password: "password"
storage:
  path: "/tmp/bitvmx"
```

### Environment-Specific Configs

```bash
# Load development config
export BITVMX_ENV=development
cargo run

# Load production config
export BITVMX_ENV=production
cargo run
```

### CLI Overrides

```rust
use bitvmx_settings::Settings;

// Override from CLI
let settings = Settings::load_with_overrides(vec![
    "--configuration", "custom.yaml",
    "-c", "other.yaml"
])?;
```

## Configuration Structure

```rust
#[derive(Deserialize)]
pub struct Settings {
    pub network: Network,
    pub bitcoin: BitcoinConfig,
    pub storage: StorageConfig,
    pub logging: LoggingConfig,
    // ... other settings
}
```

## API Reference

For detailed API documentation:

- [**Complete Settings API →**](../rust-api/bitvmx_settings/index.html)
- [Configuration Types](../rust-api/bitvmx_settings/index.html#structs)
- [Loading Methods](../rust-api/bitvmx_settings/index.html#functions)

## See Also

- [Storage Backend API](storage-api.md) - Configuration for storage
- [Developer Guide](../developer-guide/workspace-setup.md) - Environment setup
- [Components Overview](../components/index.md) - System configuration
