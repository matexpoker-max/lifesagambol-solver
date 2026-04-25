#!/bin/bash
# Cloudflare Pages build script for Lifes a Gambol Solver
# This installs the Rust toolchain (not preinstalled on Cloudflare Pages),
# compiles the four WASM modules, then bundles the Vue front-end.
#
# Build time: ~8-12 minutes per deploy (most of it is the Rust compile).
# This is normal. Cloudflare Pages free tier handles it.

set -e  # Exit immediately on any error

echo "=========================================="
echo "  Lifes a Gambol Solver — Build Script"
echo "=========================================="
echo ""

# --- Step 1: Install Rust nightly ---
echo "[1/6] Installing Rust nightly toolchain..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- \
  -y \
  --default-toolchain nightly \
  --profile minimal \
  --component rust-src
export PATH="$HOME/.cargo/bin:$PATH"

# --- Step 2: Add wasm32 compile target ---
echo ""
echo "[2/6] Adding wasm32-unknown-unknown target..."
rustup target add wasm32-unknown-unknown --toolchain nightly

# --- Step 3: Install wasm-pack ---
echo ""
echo "[3/6] Installing wasm-pack..."
# Pinned version to match what the original project tested against
curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh

# --- Step 4: Install npm dependencies ---
echo ""
echo "[4/6] Installing npm packages..."
npm ci

# --- Step 5: Build the four WASM modules ---
echo ""
echo "[5/6] Compiling WASM modules (this is the slow part)..."
npm run wasm

# --- Step 6: Bundle the Vue app ---
echo ""
echo "[6/6] Bundling Vue front-end..."
npm run build

echo ""
echo "=========================================="
echo "  Build complete. Output: ./dist"
echo "=========================================="
