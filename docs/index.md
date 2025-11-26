# Welcome to BitVMX Documentation

<div class="grid cards" markdown>

-   :material-cpu-64-bit:{ .lg .middle } __What is BitVMX?__

    ---

    BitVMX is a CPU for Universal Computation on Bitcoin - a covenant protocol enabling arbitrary program execution verification without requiring consensus changes.

    [:octicons-arrow-right-24: Learn more](core-concepts/what-is-bitvmx.md)

-   :material-bridge:{ .lg .middle } __Union Bridge__

    ---

    A trust-minimized bridge between Bitcoin and Rootstock powered by BitVMX, featuring 1-of-N security and packet-based architecture.

    [:octicons-arrow-right-24: Explore Union Bridge](union-bridge/introduction.md)

-   :material-rocket-launch:{ .lg .middle } __Getting Started__

    ---

    Install BitVMX and start building protocols, bridges, and applications on Bitcoin.

    [:octicons-arrow-right-24: Quick Start Guide](getting-started/quick-start.md)

-   :material-book-open-variant:{ .lg .middle } __API Reference__

    ---

    Complete API documentation for all BitVMX components and protocols.

    [:octicons-arrow-right-24: API Docs](api-reference/index.md)

</div>

## Key Features

- **🔐 Trust-Minimized** - 1-of-N security model requiring only one honest party
- **⚡ Efficient** - Hash chain system instead of Merkle trees for better performance
- **🔧 Flexible** - Supports any CPU architecture (RISC-V, MIPS, etc.)
- **🌐 Universal** - Verify any computation including ZK proofs, bridges, and oracles
- **📖 Open Source** - Fully open source and transparent development

## Quick Links

- [Architecture Overview](core-concepts/architecture.md)
- [Challenge-Response Protocol](core-concepts/challenge-response.md)
- [Union Bridge Peg-In Flow](union-bridge/pegin-flow.md)
- [Protocol Builder Deep Dive](components/protocol-builder.md)
- [First Protocol Tutorial](tutorials/first-protocol.md)

## About BitVMX

BitVMX enables **disputable computation on Bitcoin** through an optimistic verification system. Instead of executing all computation on-chain, BitVMX assumes computation is correct unless challenged. When disputes occur, an efficient challenge-response protocol resolves them using Bitcoin Script.

The system uses a RISC-V virtual CPU for universal computation support, allowing any program to be verified on Bitcoin. This opens possibilities for:

- Trust-minimized bridges (like Union Bridge)
- Bitcoin rollups
- ZK proof verification
- Decentralized oracles
- Advanced payment channels
- And much more...

## Community

Join the BitVMX community:

- [:fontawesome-brands-github: GitHub](https://github.com/FairgateLabs)
- [:fontawesome-brands-telegram: Telegram](https://t.me/+HnlusWvtyyY4YjEx)
- [:fontawesome-brands-twitter: Twitter](https://twitter.com/bitvmx)

## Latest Updates

!!! info "Documentation Status"
    This documentation is actively being developed. Some sections may be incomplete. Contributions are welcome!

---

**Ready to get started?** Head over to the [Quick Start Guide](getting-started/quick-start.md) or learn about [Core Concepts](core-concepts/index.md).
