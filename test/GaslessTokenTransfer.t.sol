// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import "../src/ERC20Permit.sol";
import "../src/app/GaslessTokenTransfer.sol";

contract GaslessTokenTransferTest is Test{
    ERC20Permit private token;
    GaslessTokenTransfer private gasless;

    uint256 constant SENDER_PRIVATE_KEY = 123;
    address sender;
    address receiver;
    uint constant AMOUNT = 1000;
    uint constant FEE = 10;
    uint deadline = block.timestamp + 1 days;

    function setUp() public{
        sender = vm.addr(SENDER_PRIVATE_KEY);
        receiver = address(2);

        token = new ERC20Permit("test", "test", 18);
        token.mint(sender, AMOUNT + FEE);

        gasless = new GaslessTokenTransfer();
    }

    function testValidSig() public{
        // Prepare permit message 
        bytes32 permitHash = _getPermitHash(sender, address(gasless), AMOUNT + FEE, token.nonces(sender), deadline);

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(SENDER_PRIVATE_KEY, permitHash);

        // Execute send
        gasless.send(
        address (token),
        sender,
        receiver,
        AMOUNT,
        FEE,
        deadline,
        // Permit signature
        v,
        r,
        s
        );


        // check token balances
        assertEq(token.balanceOf(sender), 0, "sender balance");
        assertEq(token.balanceOf(receiver), AMOUNT, "receiver balance");
        assertEq(token.balanceOf(address(this)), FEE, "contract balance");
    }

    function _getPermitHash(
        address owner,
        address spender,
        uint value,
        uint nonce,
        uint deadline
    ) private view returns (bytes32){
        return keccak256(
                    abi.encodePacked(
                        "\x19\x01",
                        token.DOMAIN_SEPARATOR(),
                        keccak256(
                            abi.encode(
                                keccak256(
                                    "Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)"
                                ),
                                owner,
                                spender,
                                value,
                                nonce,
                                deadline
                            )
                        )
                    )
                );
    }
}