// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Auction {
    address public Auctioneer;
    uint256 public HighestBid;

    mapping(address => uint) bidders;

    constructor() {
        Auctioneer = payable(msg.sender);
        HighestBid = 0;
    }

    modifier onlyOwner() {
        require(msg.sender == Auctioneer);
        _;
    }

    modifier AuctioneerCannotBid() {
        require(msg.sender != Auctioneer, "The auctioneer cannot bid");
        _;
    }

    function addBidders() public payable AuctioneerCannotBid {
        uint amount;
        amount = bidders[msg.sender] + msg.value;
        require(msg.value > 0, "Need more ether");
        bidders[msg.sender] = msg.value;
        bidders[msg.sender] = amount;
        if (amount > HighestBid) {
            HighestBid = amount;
        }
    }

    function getBal() public view returns (uint) {
        return address(this).balance;
    }

    function with() public payable onlyOwner {
        address payable to = payable(msg.sender);
        to.transfer(getBal());
    }
}
