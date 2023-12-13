// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Auction {
    address payable Auctioneer;
    address[] users;

    constructor() {
        Auctioneer = payable(msg.sender);
    }

    modifier AuctioneerCannotBid() {
        require(msg.sender != Auctioneer, "The auctioneer cannot bid");
        _;
    }

    function placeBid() public payable AuctioneerCannotBid {
        require(msg.value > 0, "Need more ether");
        uint HighestBid = 0;
        if (msg.value > HighestBid) {}
    }
}
