<template>
  <div class="max-w-3xl">
    <!-- Welcome -->
    <h2 class="text-2xl font-bold mb-3">Welcome to the table.</h2>

    <p class="mb-4">
      This is a free, open-source <span class="font-bold">GTO solver</span> —
      the same kind of brain the pros pay
      <span class="line-through text-gray-500">$1,500</span>
      <span class="font-bold">$0</span> for. It runs in your browser. No
      download, no install, no upsell. Pull up a chair.
    </p>

    <!-- The pun, briefly -->
    <p class="mb-6 text-gray-700 italic">
      "Lifes a Gambol" — to <a href="https://www.merriam-webster.com/dictionary/gambol" class="link" target="_blank" rel="noopener">gambol</a> means to frolic, to skip
      around for the joy of it. We know how it sounds. The wordplay is the
      point.
    </p>

    <!-- The give-back -->
    <div
      class="flex pl-3 pr-4 py-2.5 mb-6 text-emerald-800 bg-emerald-50 border-2 border-emerald-600 rounded-md"
    >
      <InformationCircleIcon class="inline w-5 h-5 mt-[0.1875rem] mr-2 flex-shrink-0" />
      <div>
        <span class="font-bold">10% of every dollar that comes through Lifes a Gambol goes to S.O.G.</span>
        That's the whole shape of the place. The solver, the writing, the
        tools — they all point the same direction. Play, give some back, sit down again.
      </div>
    </div>

    <!-- What this thing is -->
    <h3 class="text-lg font-bold mt-6 mb-2">What you're looking at</h3>

    <p class="mb-3">
      <span class="font-bold">GTO</span> stands for Game Theory Optimal — the
      math answer to "what should I do here?" A solver computes that answer
      for postflop spots: who bets, how much, how often, with which hands.
    </p>

    <p class="mb-3">
      The engine running under the hood is real. The
      <a href="https://github.com/b-inary/wasm-postflop#comparison" class="link" target="_blank" rel="noopener">published comparison</a>
      shows it produces results essentially identical to PioSOLVER and GTO+.
      It's not a toy. It's the same math, set loose on the open web.
    </p>

    <!-- How to use it -->
    <h3 class="text-lg font-bold mt-6 mb-2">How to use it</h3>

    <ol class="ml-6 mb-4 list-decimal">
      <li class="mb-1"><span class="font-semibold">OOP Range</span> — the out-of-position player's hands</li>
      <li class="mb-1"><span class="font-semibold">IP Range</span> — the in-position player's hands</li>
      <li class="mb-1"><span class="font-semibold">Board</span> — pick a flop (and optionally a turn/river)</li>
      <li class="mb-1"><span class="font-semibold">Tree Configuration</span> — bet sizes, raise sizes, stack depth</li>
      <li class="mb-1"><span class="font-semibold">Run Solver</span> — let it cook</li>
      <li><span class="font-semibold">Results</span> — explore the strategy</li>
    </ol>

    <p class="mb-4 text-gray-700">
      If that list made you tired, fair. A solver is a cockpit — once you've
      flown one a few times, the buttons make sense. There are good
      walkthroughs all over YouTube; we'd suggest watching one before you
      taxi out.
    </p>

    <!-- AGPL disclosure - REQUIRED, do not remove -->
    <h3 class="text-lg font-bold mt-6 mb-2">Credit & source code</h3>

    <p class="mb-3">
      The solver engine here is
      <a href="https://github.com/b-inary/wasm-postflop" class="link font-semibold" target="_blank" rel="noopener">wasm-postflop</a>
      by Wataru Inariba, released under the
      <a href="https://www.gnu.org/licenses/agpl-3.0.html" class="link" target="_blank" rel="noopener">AGPL-3.0 license</a>.
      We modified the wrapping — branding, copy, navigation — but the math is
      his work, and it's brilliant.
    </p>

    <p class="mb-3">
      Per the AGPL, the complete source for our modified version is publicly
      available:
      <a
        href="https://github.com/b-inary/wasm-postflop"
        class="link font-semibold"
        target="_blank"
        rel="noopener"
        >View source on GitHub</a>.
      If you run the code, you can read the code. That's the deal.
    </p>

    <!-- Limitations -->
    <h3 class="text-lg font-bold mt-6 mb-2">Things to know</h3>

    <ul class="ml-6 mb-4 list-disc text-gray-700">
      <li class="mb-1">
        <span class="font-semibold">iOS and Safari run in single-thread mode</span>
        — there's a longstanding WebKit
        <a href="https://bugs.webkit.org/show_bug.cgi?id=22723" class="link" target="_blank" rel="noopener">bug</a>
        that blocks the multi-threading we'd otherwise use. The solver still
        runs; it's just slower. Use Chrome or Firefox if you can.
      </li>
      <li class="mb-1">
        <span class="font-semibold">4GB memory ceiling</span> — that's a
        WebAssembly limit, not ours. Most reasonable spots fit comfortably
        underneath it.
      </li>
      <li>
        <span class="font-semibold">Desktop-first</span> — the UI is dense,
        the screens are wide. Your phone is going to have a bad time.
      </li>
    </ul>

    <p class="mt-8 text-sm text-gray-500 italic">
      If something's broken or confusing, the comedy was probably ours. Let us know.
    </p>
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import { InformationCircleIcon } from "@heroicons/vue/20/solid";

export default defineComponent({
  components: { InformationCircleIcon },
});
</script>

<style scoped>
.link {
  @apply text-blue-600 hover:underline;
}
</style>
