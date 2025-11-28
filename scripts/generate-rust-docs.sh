#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to show usage
show_usage() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Generate Rust API documentation for BitVMX crates."
    echo ""
    echo "Options:"
    echo "  -p, --path PATH    Path to rust-bitvmx-workspace directory"
    echo "  -h, --help         Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0                              # Use default path (../rust-bitvmx-workspace)"
    echo "  $0 -p /path/to/workspace        # Use custom path"
    echo "  $0 --path ~/projects/workspace  # Use custom path (long form)"
    echo ""
}

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOCS_ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

# Default workspace path (sibling directory to bitvmx-docs)
DEFAULT_WORKSPACE_DIR="$DOCS_ROOT_DIR/../rust-bitvmx-workspace"
WORKSPACE_DIR=""

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -p|--path)
            WORKSPACE_DIR="$2"
            shift 2
            ;;
        -h|--help)
            show_usage
            exit 0
            ;;
        *)
            echo -e "${RED}Error: Unknown option: $1${NC}"
            show_usage
            exit 1
            ;;
    esac
done

# If no path provided, use default
if [ -z "$WORKSPACE_DIR" ]; then
    WORKSPACE_DIR="$DEFAULT_WORKSPACE_DIR"
fi

# Store the attempted path for error message
ATTEMPTED_PATH="$WORKSPACE_DIR"

# Try to convert to absolute path and validate
if [ -d "$WORKSPACE_DIR" ]; then
    WORKSPACE_DIR="$(cd "$WORKSPACE_DIR" && pwd)"
else
    echo -e "${RED}========================================${NC}"
    echo -e "${RED}Error: Workspace Directory Not Found${NC}"
    echo -e "${RED}========================================${NC}\n"
    echo -e "${RED}The rust-bitvmx-workspace directory was not found at:${NC}"
    echo -e "  ${ATTEMPTED_PATH}\n"
    echo -e "${YELLOW}Solutions:${NC}"
    echo -e "  1. Clone the workspace repository to the default location:"
    echo -e "     ${BLUE}git clone <repo-url> ../rust-bitvmx-workspace${NC}"
    echo -e "     (relative to bitvmx-docs directory)\n"
    echo -e "  2. Specify a custom path using the --path flag:"
    echo -e "     ${BLUE}$0 --path /path/to/rust-bitvmx-workspace${NC}\n"
    exit 1
fi

# Configuration
DOCS_DIR="$DOCS_ROOT_DIR/docs_rust"
SITE_NAME="BitVMX"

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}BitVMX Rust API Documentation Generator${NC}"
echo -e "${BLUE}========================================${NC}\n"
echo -e "${BLUE}Workspace:${NC} $WORKSPACE_DIR"
echo -e "${BLUE}Output:${NC}    $DOCS_DIR\n"

# Array of crates to document (crate_dir:crate_name:lib_name)
CRATES=(
    "rust-bitvmx-client:bitvmx-client:bitvmx_client"
    "rust-bitvmx-protocol-builder:bitvmx-protocol-builder:protocol_builder"
    "rust-bitvmx-key-manager:bitvmx-key-manager:key_manager"
    "rust-bitvmx-storage-backend:rust-bitvmx-storage-backend:storage_backend"
    "rust-bitvmx-broker:bitvmx-broker:bitvmx_broker"
    "rust-bitcoin-coordinator:bitcoin-coordinator:bitcoin_coordinator"
    "rust-bitcoin-indexer:bitcoin-indexer:bitcoin_indexer"
    "rust-bitvmx-transaction-monitor:bitvmx-transaction-monitor:bitvmx_transaction_monitor"
    "rust-bitvmx-wallet:bitvmx-wallet:bitvmx_wallet"
    "rust-bitvmx-settings:bitvmx-settings:bitvmx_settings"
)

# Clean previous build
echo -e "${BLUE}Cleaning previous documentation...${NC}"
rm -rf "$DOCS_DIR"
mkdir -p "$DOCS_DIR"

echo -e "${GREEN}Generating Rust documentation for all crates...${NC}\n"

# Counter for successful builds
SUCCESSFUL_BUILDS=0
FAILED_BUILDS=0

# Generate docs for each crate
for crate_info in "${CRATES[@]}"; do
    IFS=':' read -r crate_dir crate_name lib_name <<< "$crate_info"

    echo -e "${BLUE}Documenting: ${crate_name}${NC}"

    if [ ! -d "$WORKSPACE_DIR/$crate_dir" ]; then
        echo -e "${RED}  ✗ Directory not found: $WORKSPACE_DIR/$crate_dir${NC}"
        ((FAILED_BUILDS++))
        continue
    fi

    (
        cd "$WORKSPACE_DIR/$crate_dir"

        # Generate documentation with specific flags
        # --no-deps: Don't document dependencies
        # --lib: Only document the library (not binaries)
        if [ -f "$SCRIPT_DIR/rustdoc-header.html" ]; then
            RUSTDOCFLAGS="--html-in-header $SCRIPT_DIR/rustdoc-header.html" \
            cargo doc --no-deps --lib 2>&1 >/dev/null
        else
            echo -e "${YELLOW}  ! rustdoc-header.html not found, continuing without custom styling${NC}"
            cargo doc --no-deps --lib 2>&1 >/dev/null
        fi
    )

    BUILD_EXIT_CODE=$?

    if [ $BUILD_EXIT_CODE -eq 0 ]; then
        echo -e "${GREEN}  ✓ Generated docs for ${crate_name}${NC}"
        ((SUCCESSFUL_BUILDS++))
    else
        echo -e "${RED}  ✗ Failed to generate docs for ${crate_name}${NC}"
        ((FAILED_BUILDS++))
    fi
done

# Copy all documentation to unified location
echo -e "\n${BLUE}Combining documentation into unified directory...${NC}"

# Get the first successfully built crate to extract shared static files
FIRST_CRATE_DIR=""
for crate_info in "${CRATES[@]}"; do
    IFS=':' read -r crate_dir crate_name lib_name <<< "$crate_info"
    if [ -d "$WORKSPACE_DIR/$crate_dir/target/doc" ]; then
        FIRST_CRATE_DIR="$WORKSPACE_DIR/$crate_dir/target/doc"
        break
    fi
done

if [ -z "$FIRST_CRATE_DIR" ]; then
    echo -e "${RED}Error: No crates successfully built${NC}"
    exit 1
fi

# Copy static files (shared across all crates)
if [ -d "$FIRST_CRATE_DIR/static.files" ]; then
    cp -r "$FIRST_CRATE_DIR/static.files" "$DOCS_DIR/"
    echo -e "${GREEN}  ✓ Copied static assets${NC}"
fi

# Copy other shared files
for shared_file in search.desc trait.impl src-files.js search-index.js help.html; do
    if [ -d "$FIRST_CRATE_DIR/$shared_file" ] || [ -f "$FIRST_CRATE_DIR/$shared_file" ]; then
        cp -r "$FIRST_CRATE_DIR/$shared_file" "$DOCS_DIR/" 2>/dev/null || true
    fi
done

# Copy crate-specific documentation
for crate_info in "${CRATES[@]}"; do
    IFS=':' read -r crate_dir crate_name lib_name <<< "$crate_info"

    CRATE_DOC_DIR="$WORKSPACE_DIR/$crate_dir/target/doc/$lib_name"

    if [ -d "$CRATE_DOC_DIR" ]; then
        cp -r "$CRATE_DOC_DIR" "$DOCS_DIR/"
        echo -e "${GREEN}  ✓ Copied ${lib_name} docs${NC}"
    else
        echo -e "${YELLOW}  ! Docs not found for ${lib_name}${NC}"
    fi
done

# Generate a custom index.html for the docs root
cat > "$DOCS_DIR/index.html" <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BitVMX Rust API Documentation</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            line-height: 1.6;
            color: #333;
            background: #f5f5f5;
        }

        .header {
            background: #ff6f00;
            color: white;
            padding: 2rem 0;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .header-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .header h1 {
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
        }

        .header p {
            font-size: 1.1rem;
            opacity: 0.95;
        }

        .container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .back-link {
            display: inline-block;
            margin-bottom: 2rem;
            color: #ff6f00;
            text-decoration: none;
            font-weight: 500;
            font-size: 1rem;
        }

        .back-link:hover {
            text-decoration: underline;
        }

        .crate-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 20px;
        }

        .crate-card {
            background: white;
            border-radius: 8px;
            padding: 24px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .crate-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }

        .crate-card h2 {
            font-size: 1.5rem;
            margin-bottom: 12px;
        }

        .crate-card a {
            color: #ff6f00;
            text-decoration: none;
            font-weight: 600;
        }

        .crate-card a:hover {
            text-decoration: underline;
        }

        .crate-description {
            color: #666;
            margin-top: 8px;
            font-size: 0.95rem;
        }

        .footer {
            text-align: center;
            padding: 2rem 0;
            color: #666;
            margin-top: 3rem;
        }

        @media (max-width: 768px) {
            .crate-grid {
                grid-template-columns: 1fr;
            }

            .header h1 {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-content">
            <h1>BitVMX Rust API Documentation</h1>
            <p>Comprehensive API reference for all BitVMX Rust crates</p>
        </div>
    </div>

    <div class="container">
        <a href="../" class="back-link">← Back to Main Documentation</a>

        <div class="crate-grid">
            <div class="crate-card">
                <h2><a href="bitvmx_client/index.html">bitvmx_client</a></h2>
                <div class="crate-description">Main BitVMX client library for interacting with BitVMX protocols and the Bitcoin blockchain</div>
            </div>

            <div class="crate-card">
                <h2><a href="protocol_builder/index.html">protocol_builder</a></h2>
                <div class="crate-description">Build and manage DAGs of pre-signed Bitcoin transactions for protocol design</div>
            </div>

            <div class="crate-card">
                <h2><a href="key_manager/index.html">key_manager</a></h2>
                <div class="crate-description">Manage cryptographic keys for BitVMX protocol transactions with multiple signature schemes</div>
            </div>

            <div class="crate-card">
                <h2><a href="storage_backend/index.html">storage_backend</a></h2>
                <div class="crate-description">RocksDB-based encrypted storage backend for persisting BitVMX state</div>
            </div>

            <div class="crate-card">
                <h2><a href="bitvmx_broker/index.html">bitvmx_broker</a></h2>
                <div class="crate-description">Message broker service for coordinating communication between operators</div>
            </div>

            <div class="crate-card">
                <h2><a href="bitcoin_coordinator/index.html">bitcoin_coordinator</a></h2>
                <div class="crate-description">Central orchestration system for Bitcoin transaction management and monitoring</div>
            </div>

            <div class="crate-card">
                <h2><a href="bitcoin_indexer/index.html">bitcoin_indexer</a></h2>
                <div class="crate-description">Fast, persistent blockchain indexing solution for Bitcoin Core integration</div>
            </div>

            <div class="crate-card">
                <h2><a href="bitvmx_transaction_monitor/index.html">bitvmx_transaction_monitor</a></h2>
                <div class="crate-description">Real-time tracking system for monitoring UTXOs and Bitcoin transactions</div>
            </div>

            <div class="crate-card">
                <h2><a href="bitvmx_wallet/index.html">bitvmx_wallet</a></h2>
                <div class="crate-description">Wallet management for handling Bitcoin transactions and key derivation</div>
            </div>

            <div class="crate-card">
                <h2><a href="bitvmx_settings/index.html">bitvmx_settings</a></h2>
                <div class="crate-description">Configuration management system for BitVMX services with environment awareness</div>
            </div>
        </div>

        <div class="footer">
            <p>Built with <code>cargo doc</code> | BitVMX Documentation</p>
        </div>
    </div>
</body>
</html>
EOF

echo -e "${GREEN}  ✓ Created index page${NC}"

# Create crates.js for search functionality
cat > "$DOCS_DIR/crates.js" <<'EOF'
window.ALL_CRATES = [
    "bitvmx_client",
    "protocol_builder",
    "key_manager",
    "storage_backend",
    "bitvmx_broker",
    "bitcoin_coordinator",
    "bitcoin_indexer",
    "bitvmx_transaction_monitor",
    "bitvmx_wallet",
    "bitvmx_settings"
];
EOF

echo -e "${GREEN}  ✓ Created crates.js${NC}"

echo -e "\n${GREEN}========================================${NC}"
echo -e "${GREEN}Documentation Generation Complete!${NC}"
echo -e "${GREEN}========================================${NC}"
echo -e "\nResults:"
echo -e "  ${GREEN}Successful: ${SUCCESSFUL_BUILDS}${NC}"
echo -e "  ${RED}Failed: ${FAILED_BUILDS}${NC}"
echo -e "\nLocation: ${DOCS_DIR}"
echo -e "\nTo view locally:"
echo -e "  cd $DOCS_ROOT_DIR"
echo -e "  mkdocs serve"
echo -e "\nThen navigate to: http://localhost:8000/rust-api/\n"
