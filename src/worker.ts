import * as Comlink from "comlink";

type Mod = typeof import("../pkg/solver-st/solver.js");

const createHandler = (mod: Mod) => {
  return {
    game: mod.GameManager.new(),

    init(
      oopRange: Float32Array,
      ipRange: Float32Array,
      flop: Uint8Array,
      startingPot: number,
      effectiveStack: number,
      rakePercentage: number,
      rakeCap: number,
      donkOption: boolean,
      oopFlopBet: string,
      oopFlopRaise: string,
      oopTurnBet: string,
      oopTurnRaise: string,
      oopTurnDonk: string,
      oopRiverBet: string,
      oopRiverRaise: string,
      oopRiverDonk: string,
      ipFlopBet: string,
      ipFlopRaise: string,
      ipTurnBet: string,
      ipTurnRaise: string,
      ipRiverBet: string,
      ipRiverRaise: string,
      addAllInThreshold: number,
      forceAllInThreshold: number,
      mergingThreshold: number,
      addedLines: string,
      removedLines: string
    ) {
      return this.game.init(
        oopRange,
        ipRange,
        flop,
        startingPot,
        effectiveStack,
        rakePercentage,
        rakeCap,
        donkOption,
        oopFlopBet,
        oopFlopRaise,
        oopTurnBet,
        oopTurnRaise,
        oopTurnDonk,
        oopRiverBet,
        oopRiverRaise,
        oopRiverDonk,
        ipFlopBet,
        ipFlopRaise,
        ipTurnBet,
        ipTurnRaise,
        ipRiverBet,
        ipRiverRaise,
        addAllInThreshold,
        forceAllInThreshold,
        mergingThreshold,
        addedLines,
        removedLines
      );
    },

    privateCards(player: number) {
      return this.game.private_cards(player);
    },

    memoryUsage(enableCompression: boolean) {
      return Number(this.game.memory_usage(enableCompression));
    },

    allocateMemory(enableCompression: boolean) {
      this.game.allocate_memory(enableCompression);
    },

    iterate(iteration: number) {
      this.game.solve_step(iteration);
    },

    exploitability() {
      return this.game.exploitability();
    },

    finalize() {
      return this.game.finalize();
    },

    applyHistory(history: Uint32Array) {
      this.game.apply_history(history);
    },

    totalBetAmount(append: Uint32Array) {
      return this.game.total_bet_amount(append);
    },

    currentPlayer() {
      return this.game.current_player() as "oop" | "ip" | "chance" | "terminal";
    },

    numActions() {
      return this.game.num_actions();
    },

    actionsAfter(append: Uint32Array) {
      return this.game.actions_after(append);
    },

    possibleCards() {
      return this.game.possible_cards();
    },

    getResults() {
      return this.game.get_results();
    },

    getChanceReports(append: Uint32Array, numActions: number) {
      return this.game.get_chance_reports(append, numActions);
    },
  };
};

let mod: Mod | null = null;
export type Handler = ReturnType<typeof createHandler>;

const initHandler = async (_num_threads: number) => {
  mod = await import("../pkg/solver-st/solver.js");
  await mod.default();
  return Comlink.proxy(createHandler(mod));
};

const beforeTerminate = async () => {
  // No-op for single-threaded build
};

export interface WorkerApi {
  initHandler: typeof initHandler;
  beforeTerminate: typeof beforeTerminate;
}

Comlink.expose({ initHandler, beforeTerminate });
