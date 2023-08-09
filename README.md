# DNA 

## Project Installation

To get started with DNA, follow the installation steps:

\```bash
npm install -g ganache-cli truffle
npm i
npm run tests
\```

## Project Commands

For efficient development and interaction with the project, we have provided several NPM commands:

- **test**: Executes Truffle tests.
  \```bash
  npm run test
  \```

- **compile**: Compiles the smart contracts.
  \```bash
  npm run compile
  \```

- **migrate**: Deploys the smart contracts to the development network.
  \```bash
  npm run migrate
  \```

- **deploy**: An alias for migration; deploys the smart contracts.
  \```bash
  npm run deploy
  \```

- **ganache**: Starts Ganache with deterministic addresses.
  \```bash
  npm run ganache
  \```

- **start**: Starts the Truffle development console.
  \```bash
  npm run start
  \```

Please ensure that you have `ganache-cli` running (or the Ganache UI) when executing commands that need to interact with it, such as testing or migration.
