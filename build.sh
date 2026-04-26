#!/bin/bash
set -e

PINNED_NIGHTLY="nightly-2023-10-01"

echo "[1/6] Installing Rust ${PINNED_NIGHTLY}..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- \
  -y --default-toolchain ${PINNED_NIGHTLY} --profile minimal --component rust-src
export PATH="$HOME/.cargo/bin:$PATH"

echo "[2/6] Adding wasm32 target..."
rustup target add wasm32-unknown-unknown --toolchain ${PINNED_NIGHTLY}

echo "[3/6] Installing wasm-pack..."
curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh

echo "[4/6] Installing npm packages..."
npm ci

echo "[5/6] Compiling WASM modules..."
npm run wasm

echo "[5b] Patching wasm-bindgen output for webpack..."
for f in pkg/solver-mt/snippets/*/workerHelpers.js; do
  if [ -f "$f" ]; then
    echo "  Patching: $f"
    echo "  Before patch:"
    grep -c "'\.\./\.\.'" "$f" || true
    sed -i "s|'\\.\\./\\.\\.'|'../../solver.js'|g" "$f"
    sed -i 's|"\.\./\.\."|"../../solver.js"|g' "$f"
    echo "  After patch (should be 0):"
    grep -c "'\.\./\.\.'" "$f" || echo "  0"
  fi
done

echo "[6/6] Bundling Vue front-end..."
npm run build

echo "Build complete."
