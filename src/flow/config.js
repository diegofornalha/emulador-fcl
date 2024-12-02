import { config } from "@onflow/fcl";
import { networkStore } from "./stores";

const networkConfigs = {
  mainnet: {
    "accessNode.api": "https://rest-mainnet.onflow.org",
    "discovery.wallet": "https://fcl-discovery.onflow.org/authn",
    "flow.network": "mainnet",
  },
  testnet: {
    "accessNode.api": "https://rest-testnet.onflow.org",
    "discovery.wallet": "https://fcl-discovery.onflow.org/testnet/authn",
    "flow.network": "testnet",
  },
  emulator: {
    "accessNode.api": "http://localhost:8888",
    "discovery.wallet": "http://localhost:8701/fcl/authn",
    "flow.network": "emulator",
  },
};

networkStore.subscribe((network) => {
  config({
    "app.detail.title": "FCL Svelte Demo",
    "app.detail.icon": "https://placekitten.com/g/200/200",
    ...networkConfigs[network],
  });
});
