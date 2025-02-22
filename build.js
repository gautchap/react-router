import { build } from "esbuild";

build({
    entryPoints: ["./server.js"],
    minify: true,
    platform: "node",
    outfile: "./build/server.js",
}).catch(() => process.exit(1));
