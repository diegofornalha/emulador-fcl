# FCL SvelteKit Demo

Este é um projeto de demonstração que integra Flow Client Library (FCL) com SvelteKit.

## Configuração Inicial

1. Clone o repositório e instale as dependências:

```bash
yarn
```

2. Configure o ambiente:

Existem duas opções de configuração: testnet ou emulator local.

### Opção 1: Usando Testnet (Recomendado para início)

No arquivo `src/flow/config.js`, use a seguinte configuração:

```javascript
import { config } from "@onflow/fcl";

config({
  "app.detail.title": "FCL Svelte Demo",
  "app.detail.icon": "https://placekitten.com/g/200/200",
  "accessNode.api": "https://rest-testnet.onflow.org",
  "discovery.wallet": "https://fcl-discovery.onflow.org/testnet/authn",
  "flow.network": "testnet",
});
```

### Opção 2: Usando Emulator Local

1. Instale o Flow CLI:

```bash
sh -ci "$(curl -fsSL https://storage.googleapis.com/flow-cli/install.sh)"
```

Você saberá que a instalação foi bem-sucedida quando ver a mensagem:

```
Successfully installed the Flow CLI to /usr/local/bin.
```

2. Em terminais separados, execute:

```bash
# Terminal 1: Inicie o Flow Emulator
flow emulator start

# Terminal 2: Inicie o Flow Dev Wallet
flow dev-wallet
```

3. No arquivo `src/flow/config.js`, use a configuração:

```javascript
import { config } from "@onflow/fcl";

config({
  "app.detail.title": "FCL Svelte Demo",
  "app.detail.icon": "https://placekitten.com/g/200/200",
  "accessNode.api": "http://localhost:8888",
  "discovery.wallet": "http://localhost:8701/fcl/authn",
  "flow.network": "emulator",
});
```

## Executando o Projeto

1. Inicie o servidor de desenvolvimento:

```bash
yarn dev
```

2. Acesse o projeto em `http://localhost:5173` (ou a porta indicada no terminal)

## Estrutura do Projeto

```
├── src/
│   ├── flow/
│   │   ├── config.js     # Configuração FCL
│   │   ├── actions.js    # Ações Flow
│   │   └── stores.js     # Stores Svelte
│   └── lib/
│       └── Auth.svelte   # Componente de Autenticação
├── cadence/
│   ├── contracts/        # Contratos Flow
│   ├── scripts/          # Scripts Flow
│   └── transactions/     # Transações Flow
└── flow.json            # Configuração Flow
```

## Dependências Principais

- SvelteKit: Framework web
- Flow Client Library (FCL): Interação com blockchain Flow
- PicoCSS: Estilização
- Vite: Build tool

## Notas Importantes

- Certifique-se de estar usando **Node.js v16 ou superior**
- Ao alternar entre testnet e emulator, faça logout para evitar conflitos
- Para desenvolvimento local, certifique-se de que o Flow CLI está instalado

## Scripts Disponíveis

```bash
yarn dev      # Inicia servidor de desenvolvimento
yarn build    # Cria build de produção
yarn preview  # Visualiza build de produção
```

## Licença

MIT
