# BitVMX Documentation

This repository contains the official documentation for BitVMX - A CPU for Universal Computation on Bitcoin.

## About BitVMX

BitVMX is a covenant protocol enabling arbitrary program execution verification on Bitcoin without requiring consensus changes. It uses a RISC-V virtual CPU and an efficient challenge-response protocol to enable trust-minimized bridges, rollups, ZK proof verification, and more.

## Documentation

The documentation is built using [MkDocs](https://www.mkdocs.org/) with the [Material theme](https://squidfunk.github.io/mkdocs-material/).

### Local Development

#### Prerequisites

- Python 3.8+
- pip

#### Setup

1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd bitvmx-docs
   ```

2. Create and activate a virtual environment:
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

3. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

#### Running Locally

Start the development server:

```bash
mkdocs serve
```

The documentation will be available at [http://localhost:8000](http://localhost:8000).

The server will automatically reload when you make changes to the documentation.

#### Building

Build the static site:

```bash
mkdocs build
```

The built site will be in the `site/` directory.

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

## Contributing

We welcome contributions to the documentation! Please see our [Contributing Guide](docs/contributing/index.md) for details.

### Quick Contribution Guide

1. Fork this repository
2. Create a feature branch: `git checkout -b feature/my-improvement`
3. Make your changes
4. Test locally with `mkdocs serve`
5. Commit your changes: `git commit -am 'Add new documentation'`
6. Push to your fork: `git push origin feature/my-improvement`
7. Submit a Pull Request

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
