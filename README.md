# BitVMX Documentation

This repository contains the official documentation for BitVMX - A CPU for Universal Computation on Bitcoin.

The documentation is built using [MkDocs](https://www.mkdocs.org/) with the [Material theme](https://squidfunk.github.io/mkdocs-material/).

### Local Development

#### Prerequisites

- Python 3.8+
- pip

#### Setup

Create and activate a virtual environment:
   ```bash
   python -m venv venv
   source venv/bin/activate
   ```

Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

#### Running Locally

Start the development server:

```bash
mkdocs serve
```

The documentation will be available at [http://localhost:8000](http://localhost:8000).

#### Building

Build the static site:

```bash
mkdocs build
```

The built site will be in the `site/` directory.

### Rust API Documentation

The documentation includes Rust API reference docs generated from the BitVMX codebase.

#### Prerequisites

- Rust toolchain (install from [rustup.rs](https://rustup.rs/))
- Access to the `rust-bitvmx-workspace` directory
  - Default location: `../rust-bitvmx-workspace` (sibling to this repo)
  - Or use `--path` flag to specify a custom location

#### Generating Rust Docs

Generate Rust API documentation for all crates:

```bash
# Use default path (looks for rust-bitvmx-workspace in parent directory)
./scripts/generate-rust-docs.sh

# Or specify a custom path
./scripts/generate-rust-docs.sh --path /path/to/rust-bitvmx-workspace
```

**Directory Structure:**

By default, the script expects this directory structure:
```
parent-dir/
├── bitvmx-docs/          # This repository
└── rust-bitvmx-workspace/ # Rust workspace (sibling directory)
```

If your workspace is in a different location, use the `--path` flag.

**What the script does:**
1. Generate `cargo doc` for all 10 public-facing crates
2. Combine them into `docs_rust/` directory
3. Create a unified index page

The generated docs are automatically copied into the MkDocs site during build.

#### Local Development with Rust API Docs

1. Generate Rust docs first:
   ```bash
   ./scripts/generate-rust-docs.sh
   ```

2. Start MkDocs development server:
   ```bash
   mkdocs serve
   ```

3. View documentation at:
   - Main docs: [http://localhost:8000](http://localhost:8000)
   - Rust API: [http://localhost:8000/rust-api/](http://localhost:8000/rust-api/)

#### Updating Rust API Docs

After making changes to Rust code:

```bash
./scripts/generate-rust-docs.sh
```

MkDocs will auto-reload if `mkdocs serve` is running.

#### Deploying to GitHub Pages

To deploy the documentation (including Rust API docs) to GitHub Pages:

```bash
# 1. Generate Rust docs
./scripts/generate-rust-docs.sh

# 2. Build and deploy
mkdocs gh-deploy --force
```

#### Troubleshooting

**Issue:** Rust docs not showing up
**Solution:** Run `./scripts/generate-rust-docs.sh` first

**Issue:** Compilation errors in specific crates
**Solution:** Check the crate compiles: `cd ../rust-bitvmx-workspace/<crate> && cargo check`

**Issue:** Styling looks wrong
**Solution:** Clear browser cache and rebuild: `mkdocs build --clean`

## Documentation Structure

```
docs/
├── index.md                      # Home page
├── getting-started/              # Installation and quick start
├── core-concepts/                # Fundamental concepts
├── union-bridge/                 # Union Bridge documentation
├── components/                   # Component documentation
├── developer-guide/              # Development guides
├── api-reference/                # API documentation
├── tutorials/                    # Step-by-step tutorials
├── technical-reference/          # Technical specifications
├── contributing/                 # Contribution guidelines
└── resources/                    # External resources
```

## Links

- [BitVMX Website](https://bitvmx.org/)
- [GitHub Organization](https://github.com/FairgateLabs)
- [Telegram](https://t.me/+HnlusWvtyyY4YjEx)
- [Twitter](https://twitter.com/bitvmx)

## License

This documentation is licensed under the MIT License - see the LICENSE file for details.

## Support

If you have questions or need help:

- Open an [issue](https://github.com/FairgateLabs/bitvmx-docs/issues)
- Join our [Telegram channel](https://t.me/+HnlusWvtyyY4YjEx)
- Check the [FAQ](docs/getting-started/faq.md)
