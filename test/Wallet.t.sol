//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import {Wallet} from "../src/Wallet.sol";

// Example of deal and hoax
// deal(address, uint)  - set the balance of address
// hoax(address, uint) - deal + prank, Sets up a prank and set balance

contract WalletTest is Test{
    Wallet public wallet;

    function setUp() public{
        wallet = new Wallet{value: 1e18}();
    }

    function _send(uint256 amount) private{
        (bool ok,) = address(wallet).call{value: amount}("");
        require(ok, "send ETH failed");
    }

    function testEthBalance() public{
        console.log("ETH Balance", address(this).balance / 1e18);
    }

    function testSendEth() public{
        uint bal = address(wallet).balance;
        // deal(address, uint)  - set the balance of address
        deal(address(1), 100);
        assertEq(address(1).balance, 100);

        deal(address(1), 10);
        assertEq(address(1).balance, 10);


        // hoax(address, uint) - deal + prank, Sets up a prank and set balance
        deal(address(1), 123); // here we are sending the balance to the wallet
        vm.prank(address(1));
        _send(123);

        hoax(address(1), 456); //above thing also do the same thing
        _send(456);

        assertEq(address(wallet).balance, bal + 123 + 456);
    }
}
