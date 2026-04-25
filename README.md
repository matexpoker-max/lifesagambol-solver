# Lifes a Gambol — Solver

The free GTO poker solver behind **[solver.lifesagambol.com](https://solver.lifesagambol.com)**.

## What this is

A **fork** of [wasm-postflop](https://github.com/b-inary/wasm-postflop) by Wataru Inariba, with lifesagambol branding, copy, and navigation. The solver engine itself (the Rust code in `rust/`, compiled to WebAssembly) is unchanged from the upstream project. All original credit belongs to the upstream author.

## License: AGPL-3.0

This project inherits AGPL-3.0 from upstream. In practical terms:

- You're free to use, modify, and redistribute it.
- If you run a modified version on a website that other people can use, you have to make your modified source publicly available.
- That's why this repository is public — it's the source for the version running at `solver.lifesagambol.com`.

See [`LICENSE`](./LICENSE) for the full text.

## What was changed from upstream

Visible changes:

- **`index.html`** — title, meta tags, favicon reference
- **`src/components/NavBar.vue`** — header replaced with "Lifes a Gambol Solver" + back link to main site; GitHub link points to this fork
- **`src/components/AboutPage.vue`** — fully rewritten in brand voice; preserves limitation notes from upstream; includes AGPL source disclosure
- **`src/store.ts`** — about page header text
- **`package.json`** — name, description

Unchanged:

- **`rust/`** — solver engine (entire CFR algorithm)
- **`src/components/`** — all other Vue components (RangeEditor, BoardSelector, TreeConfig, RunSolver, ResultViewer, ResultTable, etc.)
- **`webpack.config.js`**, **`tailwind.config.js`**, **`postcss.config.js`** — build config
- **`public/_headers`** — required Cross-Origin-Isolation headers for SharedArrayBuffer

Added:

- **`build.sh`** — Cloudflare Pages build script (installs Rust toolchain + builds)
- **`SETUP.md`** — deployment guide

## Deploying

See [`SETUP.md`](./SETUP.md) for the full walkthrough — GitHub repo → Cloudflare Pages → custom subdomain.

## Building locally (optional)

If you want to build on your own machine instead of relying on Cloudflare Pages:

```sh
# Prerequisites
rustup install nightly
rustup +nightly component add rust-src
rustup target add wasm32-unknown-unknown
cargo install wasm-pack
npm install

# Build
npm run wasm
npm run build

# Serve locally
npm run serve
```

Or just run `bash build.sh` — same thing the Cloudflare build does.

## Upstream

- Original project: https://github.com/b-inary/wasm-postflop
- Solver engine library: https://github.com/b-inary/postflop-solver
- Original author's note about suspending development: https://github.com/b-inary/postflop-solver/issues/46

## Donations

10% of every dollar that comes in via lifesagambol.com goes to S.O.G. The solver is free. The give-back is the point.
