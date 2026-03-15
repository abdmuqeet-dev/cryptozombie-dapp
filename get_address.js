const HDWalletProvider = require('@truffle/hdwallet-provider');
const fs = require('fs');
const path = require('path');

const mnemonic = fs.readFileSync(path.join(__dirname, '.secret')).toString().trim();
const provider = new HDWalletProvider(mnemonic, 'https://sepolia.infura.io/v3/dummy'); // dummy url for initialization

console.log('Your Sepolia address:', provider.getAddress(0));

provider.engine.stop();