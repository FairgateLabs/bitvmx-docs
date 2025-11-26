# Prerequisites

Before installing BitVMX, ensure your system meets the following requirements.

## System Requirements

### Operating System

BitVMX is developed and tested on:

- **Linux** (Ubuntu 20.04+, Arch Linux, Fedora) - Recommended
- **macOS** (10.15+)
- **Windows** (via WSL2)

### Hardware

Minimum requirements:

- **CPU**: x86_64 or ARM64
- **RAM**: 8GB minimum, 16GB+ recommended
- **Storage**: 20GB+ free space
- **Network**: Internet connection for downloading dependencies

## Required Software

### Rust Toolchain

BitVMX is written in Rust. Install the latest stable Rust:

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Verify installation:

```bash
rustc --version
cargo --version
```

### Git

Install Git for version control:

=== "Ubuntu/Debian"
    ```bash
    sudo apt update
    sudo apt install git
    ```

=== "macOS"
    ```bash
    brew install git
    ```

=== "Arch Linux"
    ```bash
    sudo pacman -S git
    ```

### Bitcoin Core (Optional)

For testing and development with regtest/testnet:

- Download from [bitcoin.org](https://bitcoin.org/en/download)
- Or use Docker: `docker pull bitcoin/bitcoin`

### Docker (Optional)

Recommended for running RISC-V compilation and testing:

- Install from [docker.com](https://docs.docker.com/get-docker/)

## Optional Tools

### Python 3.8+

For testing scripts and utilities:

```bash
python3 --version
```

### Node.js (for Union Bridge Smart Contracts)

If working with Union Bridge:

```bash
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs
```

## Verify Prerequisites

Run this checklist before proceeding:

- [ ] Rust toolchain installed (`rustc --version`)
- [ ] Git installed (`git --version`)
- [ ] Sufficient disk space (20GB+)
- [ ] Internet connection available

## Next Steps

Once all prerequisites are met, proceed to [Installation](installation.md).
