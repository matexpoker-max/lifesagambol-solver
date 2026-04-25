# Deploying the Lifes a Gambol Solver

This guide takes you from "zip file on my desktop" to "working solver at solver.lifesagambol.com".

The flow is: **GitHub repo → Cloudflare Pages auto-build → custom subdomain.**
You don't build anything on your machine. Cloudflare's servers do it for you every time you push.

---

## Before you start: the one thing you MUST do

There are placeholder URLs in the code that point to the original wasm-postflop repo. **AGPL-3.0 requires that the source link visitors see points to YOUR modified version**, not the upstream.

After you've created your GitHub repo (Step 2 below), come back to this list and replace these in two files:

**File 1: `src/components/NavBar.vue`** — find:
```
href="https://github.com/b-inary/wasm-postflop"
```
Replace with your repo URL, e.g. `https://github.com/YOUR_USERNAME/lifesagambol-solver`.

**File 2: `src/components/AboutPage.vue`** — find both occurrences of:
```
href="https://github.com/b-inary/wasm-postflop"
```
Replace with your repo URL.

(The links in AboutPage that point to the *comparison results* table can stay pointed at the original — that's referencing the original author's published benchmark. Only swap the "View source on GitHub" link and the NavBar link.)

This is non-optional. Your site running modified AGPL code without a working source link is a license violation.

---

## Step 1 — Create a GitHub account (if you don't have one)

Go to [github.com](https://github.com), sign up. Free tier is fine. You'll need to verify your email.

---

## Step 2 — Create a new public repo

1. Click the `+` icon top-right → **New repository**.
2. Name: `lifesagambol-solver` (or whatever you want).
3. **Public** (this is important — AGPL means the source must be publicly accessible).
4. Don't initialize with anything (no README, no .gitignore, no license — we already have those).
5. Click **Create repository**.

GitHub will show you a page with setup instructions. Ignore them — we're going to upload via the web UI, which is simpler than the command-line option for a one-time push.

---

## Step 3 — Upload the project files

The easiest path:

1. On your new empty repo page, click **uploading an existing file** (it's a link in the middle of the page).
2. Drag the **contents** of the `lifesagambol-solver` folder into the browser. Not the folder itself — the files and subfolders inside it.
3. Wait for the upload (a few minutes — the WASM source files take a beat).
4. At the bottom: commit message like "Initial commit". Click **Commit changes**.

Now's a good time to do the URL swap from the section above. You can edit files directly in GitHub's web UI: navigate to each file, click the pencil icon, edit, commit.

---

## Step 4 — Sign up for Cloudflare Pages

1. Go to [pages.cloudflare.com](https://pages.cloudflare.com).
2. Sign up (free tier — no credit card required).
3. Verify your email.

---

## Step 5 — Connect Cloudflare Pages to your GitHub repo

1. In Cloudflare dashboard, go to **Workers & Pages** → **Create application** → **Pages** tab → **Connect to Git**.
2. Authorize Cloudflare to access your GitHub. You can grant access to just the one repo if you want.
3. Select `lifesagambol-solver`.
4. Click **Begin setup**.

---

## Step 6 — Configure the build

This is the screen where you tell Cloudflare how to build the project. Fill in exactly:

| Field | Value |
|---|---|
| Project name | `lifesagambol-solver` (used for the temporary URL) |
| Production branch | `main` |
| Framework preset | **None** |
| Build command | `bash build.sh` |
| Build output directory | `dist` |
| Root directory | *(leave blank)* |

Then expand **Environment variables (advanced)** and add:

| Variable name | Value |
|---|---|
| `NODE_VERSION` | `20` |

Click **Save and Deploy**.

The first build takes **8–12 minutes** because it has to download and compile the Rust toolchain. Subsequent builds are faster (Cloudflare caches a lot). You can watch the live build log; if anything errors, the log will tell you what.

When it succeeds, you'll get a URL like `lifesagambol-solver.pages.dev`. Click it. You should see the solver, with your branding, working.

If the build fails, copy the last 50 lines of the log and send them to me — easier to debug from the actual error than from guessing.

---

## Step 7 — Custom domain (`solver.lifesagambol.com`)

In your Cloudflare Pages project:

1. Go to the **Custom domains** tab.
2. Click **Set up a custom domain**.
3. Enter `solver.lifesagambol.com`. Cloudflare will tell you what DNS record to add.

It'll show something like:

```
Type: CNAME
Name: solver
Target: lifesagambol-solver.pages.dev
```

Now you've got two paths depending on where your DNS lives:

### Path A: DNS is at Namecheap (most likely)

1. Log into Namecheap → **Domain List** → click **Manage** next to `lifesagambol.com`.
2. **Advanced DNS** tab.
3. Click **Add new record**.
4. Type: `CNAME Record`. Host: `solver`. Value: `lifesagambol-solver.pages.dev`. TTL: Automatic.
5. Save.

DNS propagation usually takes 5–30 minutes. After that, `solver.lifesagambol.com` will load the solver, and Cloudflare will automatically issue an SSL certificate for it.

### Path B: DNS already moved to Cloudflare

If your domain's nameservers already point to Cloudflare, the custom domain setup is one click — Cloudflare adds the record itself.

---

## Updating the solver later

Once it's deployed, every time you push a change to your GitHub repo's `main` branch, Cloudflare Pages automatically rebuilds and deploys. You don't have to touch the Cloudflare dashboard again.

Edit a file in GitHub's web UI → commit → wait ~10 minutes → live.

---

## What's actually running

For your reference, here's what each piece of the stack does:

- **`rust/`** — four Rust crates that get compiled to WebAssembly. This is the actual solver math (CFR algorithm). Don't touch unless you know what you're doing.
- **`src/`** — Vue.js front-end. The branded files we modified (`NavBar.vue`, `AboutPage.vue`, `index.html`) all live here.
- **`public/_headers`** — Tells Cloudflare Pages to send the `Cross-Origin-Opener-Policy` and `Cross-Origin-Embedder-Policy` headers, which is what enables multi-threaded WASM. **Do not delete this file.** Without it the solver runs in single-thread mode (slow) at best, fails entirely at worst.
- **`build.sh`** — The script Cloudflare Pages runs on every deploy.
- **`webpack.config.js`** — Bundler config. Output goes to `dist/`.

---

## Cost

Free.

Cloudflare Pages free tier gives you: 500 builds per month, unlimited bandwidth, unlimited requests, free SSL. You're not going to hit any limits unless you're pushing dozens of times a day.

---

## If something breaks

1. **Build fails on Cloudflare** → check the build log, paste the last error to me.
2. **Site loads but solver won't run** → open browser dev tools (F12) → Console tab. Look for errors mentioning `SharedArrayBuffer` or `crossOriginIsolated`. If you see those, the `_headers` file isn't being read correctly. Verify it's still in `public/_headers`.
3. **`solver.lifesagambol.com` shows "site can't be reached"** → DNS hasn't propagated yet, or the CNAME record at Namecheap is wrong. Wait 30 min, then test with `nslookup solver.lifesagambol.com` — it should resolve to a Cloudflare IP.
4. **iOS users complain it's slow** → that's the WebKit bug mentioned in the About page. Not fixable from our end. They should use Chrome or Firefox.
