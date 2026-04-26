#!/bin/bash
# Cloudflare Pages build script for Lifes a Gambol Solver

set -e

PINNED_NIGHTLY="nightly-2023-10-01"

echo "=========================================="
echo "  Lifes a Gambol Solver — Build Script"
echo "  Rust toolchain: ${PINNED_NIGHTLY}"
echo "=========================================="
echo ""

echo "[1/6] Installing Rust ${PINNED_NIGHTLY}..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- \
  -y \
  --default-toolchain ${PINNED_NIGHTLY} \
  --profile minimal \
  --component rust-src
export PATH="$HOME/.cargo/bin:$PATH"

echo ""
echo "[2/6] Adding wasm32-unknown-unknown target..."
rustup target add wasm32-unknown-unknown --toolchain ${PINNED_NIGHTLY}

echo ""
echo "[3/6] Installing wasm-pack..."
curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh

echo ""
echo "[4/6] Installing npm packages..."
npm ci

echo ""
echo "[5/6] Compiling WASM modules (this is the slow part)..."
npm run wasm

echo ""
echo "[6/6] Bundling Vue front-end..."
npm run build

echo ""
echo "=========================================="
echo "  Build complete. Output: ./dist"
echo "=========================================="
