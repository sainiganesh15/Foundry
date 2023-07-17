// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "forge-std/console.sol";


contract FFITest is Test {
    function testFFI() public {
        string[] memory cmds = new string[](2);
        cmds[0] = "cat";
        cmds[1] = "ffi_test.txt";
        bytes memory res = vm.ffi(cmds);
        console.log(string(res));
    }
}

// forge test --match-path test/FFI.t.sol --ffi -vvvv
// ffi - foreign functioning interface