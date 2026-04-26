#!/bin/bash
# Cloudflare Pages build script for Lifes a Gambol Solver

set -e

PINNED_NIGHTLY="nightly-2023-10-01"
PINNED_WASM_PACK="0.12.1"

echo "=========================================="
echo "  Lifes a Gambol Solver — Build Script"
echo "  Rust toolchain: ${PINNED_NIGHTLY}"
echo "  wasm-pack: ${PINNED_WASM_PACK}"
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
echo "[3/6] Installing wasm-pack ${PINNED_WASM_PACK}..."
WASM_PACK_DIST="wasm-pack-v${PINNED_WASM_PACK}-x86_64-unknown-linux-musl"
curl -L "https://github.com/rustwasm/wasm-pack/releases/download/v${PINNED_WASM_PACK}/${WASM_PACK_DIST}.tar.gz" | tar xz
mv "${WASM_PACK_DIST}/wasm-pack" "$HOME/.cargo/bin/wasm-pack"
chmod +x "$HOME/.cargo/bin/wasm-pack"

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
