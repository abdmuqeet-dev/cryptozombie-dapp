pragma solidity ^0.4.25;

import "./zombiefeeding.sol";

contract ZombieHelper is ZombieFeeding {

  uint levelUpFee = 0.001 ether;

  modifier aboveLevel(uint _level, uint _zombieId) {
    require(zombies[_zombieId].level >= _level);
    _;
  }

  function withdraw() external onlyOwner {
    address _owner = owner();
    _owner.transfer(address(this).balance);
  }

  function setLevelUpFee(uint _fee) external onlyOwner {
    levelUpFee = _fee;
  }

  function levelUp(uint _zombieId) external payable {
    require(msg.value == levelUpFee);
    zombies[_zombieId].level = zombies[_zombieId].level.add(1);
  }

  function changeName(uint _zombieId, string _newName) external aboveLevel(2, _zombieId) onlyOwnerOf(_zombieId) {
    zombies[_zombieId].name = _newName;
  }

  function changeDna(uint _zombieId, uint _newDna) external aboveLevel(20, _zombieId) onlyOwnerOf(_zombieId) {
    zombies[_zombieId].dna = _newDna;
  }

  function getZombiesByOwner(address _owner) external view returns(uint[]) {
    uint[] memory result = new uint[](ownerZombieCount[_owner]);
    uint counter = 0;
    for (uint i = 0; i < zombies.length; i++) {
      if (zombieToOwner[i] == _owner) {
        result[counter] = i;
        counter++;
      }
    }
    return result;
  }

  // Leaderboard functions
  function getTopZombiesByLevel(uint _count) external view returns(uint[]) {
    require(_count > 0 && _count <= 100); // Limit to prevent gas issues
    
    uint[] memory topZombies = new uint[](_count);
    uint[] memory levels = new uint[](_count);
    
    // Initialize with first zombies
    uint found = 0;
    for (uint i = 0; i < zombies.length && found < _count; i++) {
      topZombies[found] = i;
      levels[found] = zombies[i].level;
      found++;
    }
    
    // Sort by level (simple bubble sort for small arrays)
    for (uint x = 0; x < found - 1; x++) {
      for (uint y = 0; y < found - x - 1; y++) {
        if (levels[y] < levels[y + 1]) {
          // Swap levels
          uint tempLevel = levels[y];
          levels[y] = levels[y + 1];
          levels[y + 1] = tempLevel;
          
          // Swap zombie IDs
          uint tempId = topZombies[y];
          topZombies[y] = topZombies[y + 1];
          topZombies[y + 1] = tempId;
        }
      }
    }
    
    return topZombies;
  }

  function getTopZombiesByWins(uint _count) external view returns(uint[]) {
    require(_count > 0 && _count <= 100);
    
    uint[] memory topZombies = new uint[](_count);
    uint[] memory wins = new uint[](_count);
    
    uint found = 0;
    for (uint i = 0; i < zombies.length && found < _count; i++) {
      topZombies[found] = i;
      wins[found] = zombies[i].winCount;
      found++;
    }
    
    // Sort by win count
    for (uint x = 0; x < found - 1; x++) {
      for (uint y = 0; y < found - x - 1; y++) {
        if (wins[y] < wins[y + 1]) {
          uint tempWins = wins[y];
          wins[y] = wins[y + 1];
          wins[y + 1] = tempWins;
          
          uint tempId = topZombies[y];
          topZombies[y] = topZombies[y + 1];
          topZombies[y + 1] = tempId;
        }
      }
    }
    
    return topZombies;
  }

}
