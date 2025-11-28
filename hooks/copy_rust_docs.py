"""
MkDocs hook to copy Rust documentation into the built site.

This hook runs after MkDocs builds the site and copies the generated
Rust documentation from docs_rust/ into site/rust-api/.
"""

import os
import shutil
from pathlib import Path


def on_post_build(config, **kwargs):
    """
    Copy rust documentation to site after MkDocs build.

    This runs after MkDocs generates the site and copies the
    entire docs_rust/ directory into site/rust-api/.

    Args:
        config: MkDocs configuration object
        **kwargs: Additional keyword arguments
    """
    site_dir = Path(config['site_dir'])
    docs_rust_dir = Path('docs_rust')
    target_dir = site_dir / 'rust-api'

    if docs_rust_dir.exists() and docs_rust_dir.is_dir():
        print(f"\n📦 Copying Rust documentation to {target_dir}...")

        # Remove existing rust-api directory if it exists
        if target_dir.exists():
            shutil.rmtree(target_dir)

        # Copy the entire docs_rust directory
        shutil.copytree(docs_rust_dir, target_dir)

        # Count the number of crate directories
        crate_dirs = [d for d in target_dir.iterdir() if d.is_dir() and d.name not in ['static.files', 'search.desc', 'trait.impl']]
        num_crates = len(crate_dirs)

        print(f"✅ Rust documentation copied successfully!")
        print(f"   {num_crates} crate(s) documented")

        # Print location (handle case where target is in temp directory during mkdocs serve)
        try:
            rel_path = target_dir.relative_to(Path.cwd())
            print(f"   Location: {rel_path}")
        except ValueError:
            print(f"   Location: {target_dir}")
    else:
        print(f"\n⚠️  Warning: {docs_rust_dir} not found.")
        print("   Run 'scripts/generate-rust-docs.sh' first to generate Rust API documentation.")
        print("   The site will build without Rust API docs.")
