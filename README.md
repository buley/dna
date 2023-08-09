# Project Installation
```
npm install -g ganache-cli truffle
npm i
npm run tests

```

# Project Commands

Here's a breakdown of NPM commands:

* "test": "truffle test": Executes Truffle tests.
* "compile": "truffle compile": Compiles the smart contracts.
* "migrate": "truffle migrate --network development": Deploys the smart contracts to the development network.
* "deploy": "truffle deploy --network development": An alias for migration; deploys the smart contracts.
* "ganache": "ganache-cli -d": Starts Ganache with deterministic addresses.
* "start": "truffle develop": Starts the Truffle development console.

You can run these commands with `npm run <command_name>`. For example, to compile your contracts, use `npm run compile`.

Remember to have ganache-cli running (or Ganache UI) when you try to run commands that interact with it, like testing, migration, etc.

