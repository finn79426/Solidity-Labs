// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;


contract ForLoop {
    event Log(uint256);

    function loop_ipp() public {
        for (uint256 i = 0; i < 10; i++) {
            emit Log(i);            
        }
    }

    function loop_ppi() public {
        for (uint256 i = 0; i < 10; ++i) {
            emit Log(i);            
        }
    }
}