// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import {Wallet} from "../src/Wallet.sol";

contract AuthTest is Test {
    Wallet public wallet;

    function setUp() public{
        wallet = new Wallet();
    }

    function testSetOwner() public{
        wallet.setOwner(address(1));
        assertEq(wallet.owner(), address(1));
    }

    function testFailNotOwner() public{
        vm.prank(address(1));
        wallet.setOwner(address(1));
    }

    function testFailSetOwnerAgain() public{
        // msg.sender = address(this)
        wallet.setOwner(address(1));

        // to call the setOwner function multiple times you can use vm.prank(address(1))

        vm.startPrank(address(1));


        //vm.prank(address(1));
        wallet.setOwner(address(1));

        //vm.prank(address(1));
        wallet.setOwner(address(1));

        //vm.prank(address(1));
        wallet.setOwner(address(1));

        vm.stopPrank();

        // msg.sender = address(this)
        wallet.setOwner(address(1));
    }
}