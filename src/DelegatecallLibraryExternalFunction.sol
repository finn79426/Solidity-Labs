// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

library MathLib {
    function double(uint256 x) external pure returns (uint256) {
        return x * 2;
    }
}

contract Calculator {
    function getDouble(uint256 value) external pure returns (uint256) {
        return MathLib.double(value);
    }
}