**## Contributers**
1. Abdul Muqeet Ahmed, 877550566
2. Ruman Saiyed, 819882275
3. Asim Ali Mohammed, 868328634
4. Matheen Baba Mahammed, 861600625
5. Siddhi Mane, 832480206

**Improvements:**
1. Made an Interactive UI
2. Added option to add multiple zombies with one account
3. Added a feature to delete zombie
4. Added a feature to transfer zombie by its ID
5. Added Level Up zombie Feature by clicking card
6. Shown Unique Image for every zombie using their DNA

Demo Video:
https://www.youtube.com/watch?v=l_UiEZhYeRQ

## CryptoZombie DApp – Setup & Usage

This is a full CryptoZombies‑style Ethereum DApp: a set of Solidity contracts plus a simple HTML/JS frontend that lets you create, transfer, and manage zombie NFTs.
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
   var cryptoZombiesAddress = "0x..."; // paste the deployed ZombieMarketplace address here
   ```
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

