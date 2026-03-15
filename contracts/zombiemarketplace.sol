pragma solidity ^0.4.25;

import "./zombieownership.sol";

contract ZombieMarketplace is ZombieOwnership {

  struct Listing {
    uint zombieId;
    address seller;
    uint price;
    bool active;
  }

  mapping (uint => Listing) public listings;
  uint[] public activeListings;

  event ZombieListed(uint indexed zombieId, address indexed seller, uint price);
  event ZombieSold(uint indexed zombieId, address indexed seller, address indexed buyer, uint price);
  event ListingCancelled(uint indexed zombieId, address indexed seller);

  // List a zombie for sale
  function listZombie(uint _zombieId, uint _price) external onlyOwnerOf(_zombieId) {
    require(_price > 0, "Price must be greater than 0");
    require(!listings[_zombieId].active, "Zombie already listed");

    listings[_zombieId] = Listing({
      zombieId: _zombieId,
      seller: msg.sender,
      price: _price,
      active: true
    });

    activeListings.push(_zombieId);
    emit ZombieListed(_zombieId, msg.sender, _price);
  }

  // Buy a listed zombie
  function buyZombie(uint _zombieId) external payable {
    Listing storage listing = listings[_zombieId];
    require(listing.active, "Zombie not listed for sale");
    require(msg.value >= listing.price, "Insufficient payment");
    require(msg.sender != listing.seller, "Cannot buy your own zombie");

    // Transfer zombie ownership
    _transfer(listing.seller, msg.sender, _zombieId);

    // Transfer payment to seller
    listing.seller.transfer(listing.price);

    // Refund excess payment
    if (msg.value > listing.price) {
      msg.sender.transfer(msg.value - listing.price);
    }

    // Remove from active listings
    listing.active = false;
    _removeFromActiveListings(_zombieId);

    emit ZombieSold(_zombieId, listing.seller, msg.sender, listing.price);
  }

  // Cancel a listing
  function cancelListing(uint _zombieId) external {
    Listing storage listing = listings[_zombieId];
    require(listing.active, "Zombie not listed");
    require(listing.seller == msg.sender, "Not the seller");

    listing.active = false;
    _removeFromActiveListings(_zombieId);

    emit ListingCancelled(_zombieId, msg.sender);
  }

  // Get all active listings
  function getActiveListings() external view returns(uint[]) {
    return activeListings;
  }

  // Get listing details
  function getListing(uint _zombieId) external view returns(uint, address, uint, bool) {
    Listing storage listing = listings[_zombieId];
    return (listing.zombieId, listing.seller, listing.price, listing.active);
  }

  // Internal function to remove from active listings array
  function _removeFromActiveListings(uint _zombieId) internal {
    for (uint i = 0; i < activeListings.length; i++) {
      if (activeListings[i] == _zombieId) {
        activeListings[i] = activeListings[activeListings.length - 1];
        activeListings.length--;
        break;
      }
    }
  }

  // Get marketplace statistics
  function getMarketStats() external view returns(uint, uint) {
    uint totalVolume = 0;
    uint activeCount = 0;

    for (uint i = 0; i < activeListings.length; i++) {
      uint zombieId = activeListings[i];
      if (listings[zombieId].active) {
        activeCount++;
        totalVolume += listings[zombieId].price;
      }
    }

    return (activeCount, totalVolume);
  }
}