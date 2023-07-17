//SPDX-License-Identifier:MIT
pragma solidity ^0.8.17;

interface IVyperStorage {
    function store(uint256 val) external;
    function get() external view returns (uint256);
}