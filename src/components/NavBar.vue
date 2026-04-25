<template>
  <nav
    class="sticky flex top-0 z-30 w-full h-10 shadow-lg px-4 justify-center bg-slate-800 text-gray-50"
  >
    <div class="flex relative w-full">
      <div class="flex items-center z-10">
        <a
          href="https://lifesagambol.com"
          class="flex items-center px-3 h-full font-semibold hover:bg-slate-700 transition-colors"
          title="Back to Lifes a Gambol"
        >
          <span class="mr-2 text-blue-200">←</span>
          <span class="text-lg">Lifes a Gambol</span>
          <span class="ml-2 text-sm font-normal text-blue-200 hidden sm:inline">Solver</span>
        </a>
      </div>

      <div class="flex ml-auto h-full items-center z-10">
        <a
          href="https://github.com/matexpoker-max/lifesagambol-solver"
          class="flex px-4 h-full items-center text-sm font-medium hover:bg-slate-700"
          target="_blank"
          rel="noopener"
          title="Modified from wasm-postflop (AGPL-3.0). Source code available."
        >
          Source (AGPL)
        </a>
      </div>

      <div
        class="flex absolute w-full h-full left-0 top-0 gap-3 justify-center"
      >
        <button
          :class="
            'flex relative w-32 items-center justify-center font-semibold ' +
            'transition-colors hover:bg-slate-700 hover:text-blue-200 ' +
            (store.navView === 'solver' ? 'bg-slate-700 text-blue-200' : '')
          "
          @click="store.navView = 'solver'"
        >
          <ComputerDesktopIcon class="w-6 h-6" />
          <span class="pl-3">Solver</span>
        </button>
        <button
          :class="
            'flex relative w-32 items-center justify-center font-semibold ' +
            'transition-colors hover:bg-slate-700 hover:text-blue-200 ' +
            (store.navView === 'results' ? 'bg-slate-700 text-blue-200' : '')
          "
          @click="store.navView = 'results'"
        >
          <ChartBarIcon class="w-6 h-6" />
          <span class="pl-3">Results</span>
        </button>
      </div>
    </div>
  </nav>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import { useStore } from "../store";

import { ComputerDesktopIcon, ChartBarIcon } from "@heroicons/vue/24/solid";

export default defineComponent({
  components: {
    ComputerDesktopIcon,
    ChartBarIcon,
  },
  setup() {
    return {
      store: useStore(),
    };
  },
});
</script>
