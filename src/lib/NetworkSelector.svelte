<script>
  import { networkStore } from "../flow/stores";
  import * as fcl from "@onflow/fcl";

  const networks = [
    { id: "mainnet", label: "Mainnet" },
    { id: "testnet", label: "Testnet" },
    { id: "emulator", label: "Emulator" },
  ];

  // Função para lidar com a mudança de rede
  async function handleNetworkChange(newNetwork) {
    try {
      // Faz logout antes de mudar a rede
      await fcl.unauthenticate();
      // Atualiza a rede
      $networkStore = newNetwork;

      // Pequeno delay para garantir que a configuração da rede foi atualizada
      setTimeout(() => {
        fcl.logIn();
      }, 500);
    } catch (error) {
      console.error("Erro ao mudar de rede:", error);
    }
  }
</script>

<div class="network-selector">
  {#each networks as network}
    <label>
      <input
        type="radio"
        name="network"
        value={network.id}
        checked={$networkStore === network.id}
        on:change={() => handleNetworkChange(network.id)}
      />
      {network.label}
    </label>
  {/each}
</div>

<style>
  .network-selector {
    display: flex;
    gap: 1rem;
    padding: 1rem;
    background: #f5f5f5;
    border-radius: 8px;
    margin: 1rem 0;
  }

  label {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    cursor: pointer;
  }
</style>
