##Contributers
1. Abdul Muqeet Ahmed, 877550566, abdulmuqeet@csu.fullerton.edu
2. Ruman Saiyed, 819882275, ruman23@csu.fullerton.edu



## CryptoZombie DApp – Setup & Usage

This is a full CryptoZombies‑style Ethereum DApp: a set of Solidity contracts plus a simple HTML/JS frontend that lets you create, battle, and manage zombie NFTs.

---

## Prerequisites

- **Node.js** (v18+ recommended)
- **npm**
- **Truffle CLI** installed globally:
  ```bash
  npm install -g truffle
  ```
- A local blockchain:
  - **Ganache GUI** or
  - `ganache-cli` (installed globally or via `npx`)
- **MetaMask** browser extension

---

## 1. Install dependencies

From the project root:

```bash
cd "Cryptozombie DApp"
npm install
```

---

## 2. Run a local blockchain (Ganache)

You can use either Ganache GUI or ganache-cli.

- **Ganache GUI**
  - Start Ganache and open/create a workspace.
  - Make sure the RPC server is something like:
    - `http://127.0.0.1:7545` (port may differ).

- **ganache-cli**
  ```bash
  npx ganache-cli --port 7545
  ```

Leave Ganache running; Truffle and MetaMask will connect to it.

---

## 3. Configure Truffle network

The `development` network is defined in `truffle-config.js`:

- `host`: `127.0.0.1`
- `port`: should match your Ganache port (e.g. `7545`)
- `network_id`: should match Ganache’s network id (e.g. `5777`)

If Ganache shows a different network id, update `network_id` accordingly.

---

## 4. Compile and migrate contracts

From the project root:

```bash
truffle compile
truffle migrate --network development
```

This writes ABI and deployment info into `build/contracts/*.json`.

---

## 5. Hook up the frontend to the deployed contract

After migration:

1. Open `build/contracts/ZombieOwnership.json`.
2. Find the `networks` entry for your local network id (e.g. `"5777"`).
3. Copy the `address` value.
4. In `index.html`, replace the hard‑coded address:
   ```js
   var cryptoZombiesAddress = "0x..."; // paste the deployed ZombieOwnership address here
   ```
5. Save the file.

---

## 6. Configure MetaMask for the local chain

1. Open MetaMask.
2. Add a **Custom network**:
   - **Network name**: `Ganache` (any name)
   - **RPC URL**: e.g. `http://127.0.0.1:7545`
   - **Chain ID / Network ID**: match Ganache (e.g. `5777` or `1337`)
   - **Currency symbol**: `ETH` (optional)
3. In Ganache, copy the private key of one of the pre‑funded accounts.
4. In MetaMask:
   - Click account icon → **Import account**.
   - Choose **Private Key**, paste the key, and import.
   - Switch to this imported account (it should show a large test ETH balance).

---

## 7. Run the frontend

From the project root:

```bash
npx http-server .
```

Then open the shown URL (e.g. `http://127.0.0.1:8080/index.html`) in a browser that has MetaMask installed.

On page load:

- MetaMask will prompt you to connect the site to your account.
- Approve the connection.

You can now use the buttons:

- **Create Zombie**: mints your first zombie (one free zombie per address).
- **Show Zombies**: loads and displays zombies owned by the connected address.
- **Level Up**: sends a tx to level up your zombie (requires a small test ETH fee).

Note: by design, `createRandomZombie` can only be called once per address. New zombies are usually obtained via feeding/battling logic.

---

## 8. Deploying to a public testnet (optional)

To deploy to a testnet like **Sepolia**:

1. **Install HDWalletProvider**:
   ```bash
   npm install @truffle/hdwallet-provider
   ```
2. **Create a `.secret` file** in the project root containing the mnemonic (seed phrase) of a dedicated test wallet (do not commit this file).
3. **Create an Infura (or similar) project** and get the RPC URL for Sepolia.
4. **Update `truffle-config.js`**:
   - Require `@truffle/hdwallet-provider`.
   - Add a `sepolia` network using your mnemonic and Infura URL.
5. **Deploy**:
   ```bash
   truffle migrate --network sepolia
   ```
6. **Update `index.html`** with the new Sepolia `ZombieOwnership` address (from `build/contracts/ZombieOwnership.json`, `networks["11155111"].address`).
7. **Switch MetaMask** to the Sepolia network and use a Sepolia faucet for test ETH.

---

## Contract architecture overview

- `zombiefactory.sol`: defines the `Zombie` struct, array, owner mappings, and `createRandomZombie`.
- `zombiefeeding.sol`: adds feeding/breeding logic and cooldowns, including interaction with a CryptoKitties‑style contract.
- `zombieattack.sol`: adds attack mechanics, win/loss tracking, and breeding on victory.
- `zombieownership.sol`: wraps zombies as ERC‑721 tokens (NFTs) and exposes transfer/approval functions.
- `ownable.sol`, `safemath.sol`, `erc721.sol`: support contracts for access control, safe arithmetic, and the ERC‑721 interface.

