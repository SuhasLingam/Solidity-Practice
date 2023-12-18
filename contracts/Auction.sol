// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Auction {
    address public Auctioneer;
    address public highestBidder;
    uint256 public highestBid;
    uint256 public endTime;

    mapping(address => uint) bidders;

    event BidPlaced(address indexed bidder, uint256 amount);
    event AuctionEnded(address indexed winner, uint256 amount);

    constructor(uint _auctionTime) {
        Auctioneer = payable(msg.sender);
        highestBid = 0;
        endTime = block.timestamp + _auctionTime;
    }

    modifier onlyOwner() {
        require(msg.sender == Auctioneer);
        _;
    }

    modifier AuctioneerCannotBid() {
        require(msg.sender != Auctioneer, "The auctioneer cannot bid");
        _;
    }

    modifier onlyBeforeEnd() {
        require(block.timestamp < endTime, "Auction has already ended");
        _;
    }

    modifier onlyAfterEnd() {
        require(block.timestamp >= endTime, "Auction is still ongoing");
        _;
    }

    function placeBid() external payable onlyAfterEnd AuctioneerCannotBid {
        require(
            msg.value > highestBid,
            "Your bid must be higher than the current highest bid"
        );

        if (highestBidder != address(0)) {
            payable(highestBidder).transfer(highestBid);
        }

        highestBid = msg.value;
        highestBidder = msg.sender;

        emit BidPlaced(msg.sender, msg.value);
    }

    function endAuction() external onlyOwner onlyAfterEnd {
        require(highestBidder != address(0), "Auction has no winner");
        payable(Auctioneer).transfer(highestBid);
        emit AuctionEnded(highestBidder, highestBid);
        // Reset auction state
        highestBidder = address(0);
        highestBid = 0;
    }

    function getHighestBidder() external view returns (address) {
        return highestBidder;
    }

    function getHighestBid() external view returns (uint256) {
        return highestBid;
    }

    function getAuctionEndTime() external view returns (uint256) {
        return endTime;
    }
}
