// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/console.sol";

contract Counter {
    uint256 public count;

    //function to get the current count

    function get() public view returns (uint256) {
        return count;
    }

    function inc() external {
        console.log("Here", count);
        count += 1;
    }

    function dec() external {
        count -= 1;
    }
}
