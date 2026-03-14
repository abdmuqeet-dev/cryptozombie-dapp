function setStatus(message) {
  const status = document.getElementById("status");
  if (status) {
    status.innerText = message;
  } else {
    console.log(message);
  }
}

async function transferZombie() {
  try {
    if (typeof cryptoZombies === "undefined") {
      setStatus("Contract instance not found. Make sure cryptoZombies is initialized.");
      return;
    }

    const zombieId = document.getElementById("transferZombieId").value;
    const toAddress = document.getElementById("transferToAddress").value;

    if (!zombieId || zombieId === "") {
      setStatus("Please enter a zombie ID.");
      return;
    }

    if (!toAddress || toAddress === "") {
      setStatus("Please enter a recipient address.");
      return;
    }

    const accounts = await ethereum.request({ method: "eth_requestAccounts" });
    const fromAccount = accounts[0];

    setStatus(`Transferring zombie #${zombieId} to ${toAddress}...`);

    await cryptoZombies.methods.transferFrom(fromAccount, toAddress, zombieId).send({
      from: fromAccount
    });

    setStatus(`Zombie #${zombieId} transferred successfully to ${toAddress}`);
  } catch (err) {
    console.error(err);
    setStatus("Transfer failed: " + err.message);
  }
}