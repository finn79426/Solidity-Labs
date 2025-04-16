// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract DEX {
    Token immutable public token;
    constructor(address _token) {
        token = Token(_token);
    }
}


contract Token {
    DEX immutable public dex;
    constructor(address _dex) {
        dex = DEX(_dex);
    }
}

contract Placeholder {
    // Just a empty contract.
    // Only used in testCreateNewContractAddressShouldBePredictable().
    // For determining the new created contract address.
}
