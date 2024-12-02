<script>
  import Auth from "$lib/Auth.svelte";
  import NetworkSelector from "$lib/NetworkSelector.svelte";
  import { networkStore } from "../flow/stores";
</script>

<NetworkSelector />
<Auth />

{#if $networkStore === "emulator"}
  <div class="warning">
    ⚠️ Para usar o emulador, certifique-se de executar:
    <pre>
      flow emulator start
      flow dev-wallet
    </pre>
  </div>
{/if}

<style>
  .warning {
    background: #fff3cd;
    padding: 1rem;
    border-radius: 8px;
    margin: 1rem 0;
  }
</style>
