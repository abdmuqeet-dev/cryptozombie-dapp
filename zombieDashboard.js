function zombieImageFromDna(dna) {
  return "https://robohash.org/" + dna + "?set=set2";
}

function isReady(readyTime) {
  const now = Math.floor(Date.now() / 1000);
  return Number(readyTime) <= now;
}

function renderZombieCard(zombie, id) {
  const statusClass = isReady(zombie.readyTime) ? "ready" : "cooling";
  const statusText = isReady(zombie.readyTime) ? "Ready" : "Cooling Down";

  return `
    <div class="zombie-card" data-id="${id}">
      <div class="zombie-dna-bar"></div>
      <div class="zombie-inner">
        <div class="zombie-level-badge">LVL ${zombie.level}</div>

        <div style="text-align:center; margin-bottom: 14px;">
          <img
            src="${zombieImageFromDna(zombie.dna)}"
            alt="Zombie ${id}"
            style="width:100%; max-width:180px; border-radius:8px; border:1px solid #1f3d1f;"
          >
        </div>

        <div class="zombie-name">${zombie.name || "Unnamed Zombie"}</div>

        <div class="zombie-stats">
          <div class="stat">
            <div class="stat-label">ID</div>
            <div class="stat-value">${id}</div>
          </div>

          <div class="stat">
            <div class="stat-label">Status</div>
            <div class="stat-value ${statusClass}">${statusText}</div>
          </div>

          <div class="stat wins">
            <div class="stat-label">Wins</div>
            <div class="stat-value">${zombie.winCount}</div>
          </div>

          <div class="stat losses">
            <div class="stat-label">Losses</div>
            <div class="stat-value">${zombie.lossCount}</div>
          </div>

          <div class="stat dna">
            <div class="stat-label">DNA Sequence</div>
            <div class="stat-value">${zombie.dna}</div>
          </div>
        </div>
      </div>
    </div>
  `;
}

async function showZombieDashboard() {
  const zombiesDiv = document.getElementById("zombies");

  try {
    if (!zombiesDiv) {
      console.error('Missing #zombies container');
      return;
    }

    if (typeof cryptoZombies === "undefined" || !cryptoZombies) {
      zombiesDiv.innerHTML = `
        <div class="empty-state">
          <span class="skull">💀</span>
          <p>Contract not loaded yet.</p>
        </div>`;
      return;
    }

    if (typeof userAccount === "undefined" || !userAccount) {
      zombiesDiv.innerHTML = `
        <div class="empty-state">
          <span class="skull">💀</span>
          <p>Wallet not connected.</p>
        </div>`;
      return;
    }

    zombiesDiv.innerHTML = `
      <div class="empty-state">
        <span class="skull">☠</span>
        <p>Loading zombie dashboard...</p>
      </div>`;

    const zombieIds = await cryptoZombies.methods.getZombiesByOwner(userAccount).call();

    if (!zombieIds || zombieIds.length === 0) {
      zombiesDiv.innerHTML = `
        <div class="empty-state">
          <span class="skull">💀</span>
          <p>No zombies found. Raise your first zombie.</p>
        </div>`;
      if (typeof setStatus === "function") {
        setStatus("No zombies found.", true);
      }
      return;
    }

    let html = "";

    for (let i = 0; i < zombieIds.length; i++) {
      const id = zombieIds[i];
      const zombie = await getZombieDetails(id);
      html += renderZombieCard(zombie, id);
    }

    zombiesDiv.innerHTML = html;

    if (typeof setStatus === "function") {
      setStatus("✓ Zombie dashboard loaded.");
    }
  } catch (err) {
    console.error("Dashboard error:", err);
    zombiesDiv.innerHTML = `
      <div class="empty-state">
        <span class="skull">💀</span>
        <p>Dashboard error: ${err.message}</p>
      </div>`;
    if (typeof setStatus === "function") {
      setStatus("Dashboard error: " + err.message, true);
    }
  }
}