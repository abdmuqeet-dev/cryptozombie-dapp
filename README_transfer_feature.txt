CryptoZombies DApp – Midterm Project

Team Member Contribution

Feature Added: Zombie Transfer Functionality

Contributor: Siddhi Mane

Description of Improvement:
I implemented a frontend feature that allows a user to transfer ownership of a zombie to another Ethereum address directly from the DApp interface. This feature uses the existing ZombieOwnership smart contract function `transferFrom`.

What the Feature Does:

* Allows the zombie owner to input a zombie ID.
* Allows the owner to enter the recipient Ethereum address.
* Sends a transfer transaction through MetaMask.
* Displays success or error messages on the webpage.

Files Added:

* transferZombieFeature.js
* transfer_feature.html
* README_transfer_feature.txt

How the Feature Works:

1. The user enters the zombie ID they own.
2. The user enters the recipient Ethereum address.
3. The user clicks the “Transfer Zombie” button.
4. MetaMask prompts the user to confirm the transaction.
5. After confirmation, the zombie ownership is transferred to the new address.

Demo Instructions:

1. Open the DApp in the browser.
2. Make sure MetaMask is connected to the Ganache network.
3. Enter a zombie ID owned by the current account.
4. Enter another Ethereum address from Ganache.
5. Click "Transfer Zombie".
6. Confirm the transaction in MetaMask.
7. The zombie ownership will be transferred to the new address.

Note:
This feature extends the DApp functionality by allowing users to interact with the ZombieOwnership smart contract directly from the user interface, demonstrating additional Web3.js interaction with the blockchain.
