//SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import {Auction} from "../src/Time.sol";

contract TimeTest is Test{
    Auction public auction;
    uint256 private startAt;

    // vm.wrap - set block.timestamp to future timestamp
    

    function setUp() public{
        auction = new Auction();
        startAt = block.timestamp;
    }

    function testBidFailsBeforeStartTime() public{
        vm.expectRevert(bytes("cannot bid"));
        auction.bid();
    }

    // function testBid() public{
    //     vm.wrap(startAt + 1 days);
    //     auction.bid();
    // }

    // function testBidFailsAfterEndTime() public{
    //     vm.expectRevert(bytes("cannot bid"));
    //     vm.wrap(startAt + 2 days);
    //     auction.bid();
    // }

    function testTimestamp() public{
        uint t = block.timestamp;

        // skip - increment current timestamp
        skip(100);
        assertEq(block.timestamp, t + 100);
        // rewind - decrement current timestamp

        rewind(10);
        assertEq(block.timestamp, t + 100 - 10);
    }

    function testBlockNumber() public{
        // vm.roll set block.number
        uint b = block.number;
        vm.roll(999);
        assertEq(block.number, 999);
    }

}