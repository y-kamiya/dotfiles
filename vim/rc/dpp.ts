import { BaseConfig } from "jsr:@shougo/dpp-vim/config";
import type { ConfigArguments, ConfigReturn } from "jsr:@shougo/dpp-vim/config";
import type { Plugin } from "jsr:@shougo/dpp-vim/types";

const RC_DIR = "~/.vim/rc";
const TOML = `${RC_DIR}/dein.toml`;
const LAZY_TOML = `${RC_DIR}/deinlazy.toml`;
const CONFIG_TS = `${RC_DIR}/dpp.ts`;

export class Config extends BaseConfig {
  override async config(args: ConfigArguments): Promise<ConfigReturn> {
    args.contextBuilder.setGlobal({
      protocols: ["git"],
    });

    const [context, options] = await args.contextBuilder.get(args.denops);

    const extAction = (extName: string, action: string, params?: unknown) =>
      args.dpp.extAction(args.denops, context, options, extName, action, params);

    const loadToml = (path: string, lazy = false) =>
      extAction("toml", "load", { path, options: lazy ? { lazy: true } : {} }) as
        Promise<{ plugins: Plugin[] } | undefined>;

    const plugins = [
      ...((await loadToml(TOML))?.plugins ?? []),
      ...((await loadToml(LAZY_TOML, true))?.plugins ?? []),
    ];

    const lazyResult = await extAction(
      "lazy", "makeState",
      { plugins },
    ) as { plugins: Plugin[]; stateLines: string[] } | undefined;

    return {
      plugins: lazyResult?.plugins ?? plugins,
      stateLines: lazyResult?.stateLines ?? [],
      checkFiles: [TOML, LAZY_TOML, CONFIG_TS],
    };
  }
}
