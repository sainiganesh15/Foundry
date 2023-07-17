//SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import {Event} from "../src/Event.sol";

// forge test --match-path test/Event.t.sol -vvv

contract EventTest is Test{
    Event public e;

    event Transfer(address indexed from, address indexed to, uint256 amount);

    function setUp() public{
        e = new Event();
    }

    function testEmitTransferEvent() public{
        // function expectEmit(
        //     bool checkTopic1,
        //     bool checkTopic2,
        //     bool checkTopic3,
        //     bool checkData
        // ) external;

        // 1. Tell foundry which data to check
        // Check index 1, index 2 and date
        vm.expectEmit(true, true, false, true);// here 1st true means checking for index 1, 2nd true is for checking for index 2, 
                                               //3rd false is that we r not checking for index 3
                                               //and 4th true means checking rest of the data
                                                
        // 2. Emit the expected event
        emit Transfer(address(this), address(124), 456);

        // 3. call the function that should emit the event
        e.transfer(address(this), address(124), 456);

        // Check index 1
        vm.expectEmit(true, false, false, false); 
        emit Transfer(address(this), address(124), 456);
        e.transfer(address(this), address(12), 45);

    }

    function testEmitManyTransferEvent() public{
        //prepare the amount of parameters 
        address[] memory to = new address[](2);
        to[0] = address(123);
        to[1] = address(456);

        uint256[] memory amounts = new uint256[](2);
        amounts[0] = 777;
        amounts[1] = 888;


        for (uint i; i < to.length; i++){
            // 1. Tell foundry which data to check
            // 2. Emit the expected event
            vm.expectEmit(true, true, false, true);
            emit Transfer(address(this), to[i], amounts[i]);
        }
        // 3. call the function that should emit the event
        e.transferMany(address(this), to, amounts);
    }
}