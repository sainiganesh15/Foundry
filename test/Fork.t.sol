//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "forge-std/console.sol";

interface IWETH {
    function balanceOf(address) external view returns(uint256);
    function deposit() external payable;
}

contract ForkTest is Test{
    IWETH public weth;
    function setUp() public{
        weth = IWETH(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
    }

    function testWeth() public{
        uint balBefore = weth.balanceOf(address(this));
        console.log("balance before", balBefore);

        weth.deposit{value: 100}();

        uint balAfter = weth.balanceOf(address(this));
        console.log("balance after", balAfter);
    }
}

// command : forge test fork-url https://eth-mainnet.g.alchemy.com/v2/_KzxTpzEzHqNs4Jn_05qMzN4AJSQ50K4 --match-p ath test/Fork.t.sol
// get this url from alchemy