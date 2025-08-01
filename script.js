const gameInfo = {
  "future-wars": {
    title: "Future Wars",
    description: "Future Wars is a sci-fi shooter game set in a dystopian future where players must fight against alien invaders to save humanity.",
    features: [
      "Intense single-player campaign",
      "Multiplayer modes with up to 64 players",
      "Customizable weapons and gear"
    ],
    editions: ["Standard", "7-day key"],
    platforms: ["PC", "PlayStation 5"]
  },
  "pixel-quest": {
    title: "Pixel Quest",
    description: "Classic pixel art adventure platformer.",
    features: [
      "Retro graphics",
      "Challenging levels",
      "Unlockable characters"
    ],
    editions: ["Standard"],
    platforms: ["PC", "Nintendo Switch"]
  },
  "rs-6": {
    title: "Tom Clancy's Rainbow Six Siege",
    description: "A tactical first-person shooter focused on team-based strategy and environment destruction.",
    features: [
      "Tactical 5v5 gameplay",
      "Operator selection system",
      "Realistic destructible environments"
    ],
    editions: ["Standard", "30-day key", "7-day key"],
    platforms: ["PC", "PlayStation 5", "Xbox Series X"]
  },
  "battlefield-5": {
    title: "Battlefield 5",
    description: "Experience World War II like never before in this large-scale multiplayer shooter.",
    features: [
      "Grand Operations mode",
      "Realistic visuals and sound",
      "Expansive vehicle combat"
    ],
    editions: ["Standard", "30-day key", "7-day key"],
    platforms: ["PC"]
  },
  "Dying-light": {
    title: "Dying Light",
    description: "Open-world zombie survival game featuring parkour movement and a dynamic day-night cycle.",
    features: [
      "First-person parkour and melee combat",
      "Scary night-time gameplay",
      "Co-op and multiplayer modes"
    ],
    editions: ["Standard", "30-day key", "7-day key"],
    platforms: ["PC"]
  },
  "Firewatch": {
    title: "Firewatch",
    description: "A narrative adventure game set in a Wyoming forest, following the story of a fire lookout named Henry.",
    features: [
      "Emotional story-driven experience",
      "Stunning hand-painted visuals",
      "Immersive voice acting"
    ],
    editions: ["Standard"],
    platforms: ["PC", "PlayStation 4", "X-box One"]
  },
  "Cyberpunk_2077": {
    title: "Cyberpunk 2077",
    description: "Open-world RPG set in a dystopian future filled with cybernetic enhancements and corporate control.",
    features: [
      "Deep story and branching paths",
      "Customizable character builds",
      "Massive open-world exploration"
    ],
    editions: ["Standard", "30-day key"],
    platforms: ["PC", "PlayStation 5"]
  },
  "the-last-of-us": {
    title: "The Last of Us",
    description: "Story-rich post-apocalyptic survival game featuring Joel and Ellie on a journey through a broken world.",
    features: [
      "Emotional narrative",
      "Stealth and survival mechanics",
      "Critically acclaimed soundtrack"
    ],
    editions: ["Standard", "30-day key"],
    platforms: ["PlayStation 4", "PlayStation 5", "PC"]
  },
  "GTA5": {
    title: "Grand Theft Auto V",
    description: "Action-adventure game with an open-world sandbox and three playable protagonists.",
    features: [
      "Single-player and GTA Online",
      "Massive open-world environment",
      "Multiplayer heists and roleplay support"
    ],
    editions: ["Standard", "30-day key", "7-day key"],
    platforms: ["PC", "PlayStation 5", "Xbox Series X"]
  }
};

document.querySelectorAll('.learn-more-link').forEach(link => {
  link.addEventListener('click', function(e) {
    e.preventDefault();
    const gameKey = this.getAttribute('data-game');
    const info = gameInfo[gameKey];
    if (info) {
      let featuresHtml = "";
      if (info.features) {
        featuresHtml = "<p>Features include:</p><ul>" +
          info.features.map(f => `<li>${f}</li>`).join("") +
          "</ul>";
      }
      let editionsHtml = "";
      if (info.editions) {
        editionsHtml = `<div>
          <label for="learn-more-edition">Choose edition:</label>
          <select id="learn-more-edition">
            ${info.editions.map(e => `<option value="${e}">${e}</option>`).join("")}
          </select>
        </div>`;
      }
      let platformsHtml = "";
      if (info.platforms) {
        platformsHtml = `<p><strong>Platforms:</strong> ${info.platforms.join(", ")}</p>`;
      }
      document.getElementById('game-details').innerHTML = `
        <h2>${info.title}</h2>
        <p>${info.description}</p>
        ${platformsHtml}
        ${featuresHtml}
        ${editionsHtml}
        <button id="buy-btn">Buy</button>
      `;
      document.getElementById('learn-more-section').style.display = 'block';
      document.getElementById('checkout-section').style.display = 'none';
      window.scrollTo({
        top: document.getElementById('learn-more-section').offsetTop,
        behavior: 'smooth'
      });

      // Buy button logic
      document.getElementById('buy-btn').onclick = function() {
        document.getElementById('learn-more-section').style.display = 'none';
        document.getElementById('checkout-section').style.display = 'block';
        document.getElementById('selected-game-title').textContent = info.title;
        // Fill editions dropdown
        const editionSelect = document.getElementById('selected-edition');
        editionSelect.innerHTML = info.editions.map(e => `<option value="${e}">${e}</option>`).join("");
        // Set selected edition from learn-more dropdown
        const selectedEdition = document.getElementById('learn-more-edition')?.value || info.editions[0];
        editionSelect.value = selectedEdition;
        window.scrollTo({
          top: document.getElementById('checkout-section').offsetTop,
          behavior: 'smooth'
        });
      };
    }
  });
});




document.getElementById('close-details').onclick = function() {
  document.getElementById('learn-more-section').style.display = 'none';
};

document.getElementById('checkout-form').addEventListener('submit', function(e) {
  e.preventDefault();
  document.getElementById('demo-modal').style.display = 'flex';
});
document.getElementById('close-demo-modal').onclick = function() {
  document.getElementById('demo-modal').style.display = 'none';
};
document.getElementById('close-demo-modal').onclick = function() {
  document.getElementById('demo-modal').style.display = 'none';
};


document.getElementById('cancel-checkout').addEventListener('click', function() {
  document.getElementById('checkout-section').style.display = 'none';
});