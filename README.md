https://github.com/abdmuqeet-dev/cryptozombie-dapp

**## Contributers**
1. Abdul Muqeet Ahmed, 877550566
2. Ruman Saiyed, 819882275
3. Asim Ali Mohammed, 868328634
4. Matheen Baba Mahammed, 861600625
5. Siddhi Mane, 832480206

Demo Video:
https://www.youtube.com/watch?v=l_UiEZhYeRQ

**Improvements:**
1. Interactive UI
The application features a dark-themed, retro-styled interface with animated elements, glowing text effects, and smooth transitions that create an immersive zombie-themed experience. The design includes scanline overlays, fog effects, and responsive layouts that work seamlessly across desktop and mobile devices.

2. Multiple Zombies Per Account
Users can create and manage multiple zombies under a single Ethereum account, allowing them to build an entire horde of undead creatures. This feature enables players to experiment with different zombie combinations and strategies without needing multiple wallets.

3. Name Zombies Before Creation
Before summoning a zombie, users can enter a custom name through a modal dialog to personalize their creation. This adds a personal touch to each zombie and makes managing a large collection more intuitive and memorable.

4. Delete Zombie Feature
Players can permanently remove unwanted zombies from their collection by transferring them to a burn address. This housekeeping feature helps keep zombie armies organized and manageable.

5. Transfer Zombie by ID
Users can send any of their zombies to another Ethereum address by specifying the zombie's ID and the recipient's wallet address. This feature enables trading, gifting, and collaborative gameplay between players.

6. Level Up Zombie by Card Selection
Clicking a zombie card selects it, allowing players to level it up by paying 0.001 ETH through the Level Up button. Each level-up increases the zombie's power and unlocks new abilities in the ecosystem.

7. Unique Imagery Based on DNA
Each zombie displays a unique emoji avatar determined by their DNA sequence, creating visual variety and making each creature feel distinct. This genetic-based randomization ensures that no two zombies appear identical, reinforcing the uniqueness of each NFT.


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

