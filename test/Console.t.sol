// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";

contract ConsoleTest is Test {
    function testLogSomething() view public{
        console.log("Log something here", 123);

        int x = -1;
        console.logInt(x);
    }
}