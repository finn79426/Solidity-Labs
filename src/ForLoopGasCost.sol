// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;


contract ForLoopGasCost {
    event Log(uint256);

    // Gas Report = 33653
    function loop_ipp() public {
        for (uint256 i = 0; i < 10; i++) {
            emit Log(i);            
        }
    }

    // Gas Report = 33625
    function loop_ppi() public {
        for (uint256 i = 0; i < 10; ++i) {
            emit Log(i);            
        }
    }

    // Gas Report = 33631
    function loop_unchecked_ipp() public {
        unchecked {
            for (uint256 i = 0; i < 10; i++) {
                emit Log(i);            
            }
        }
    }

    // Gas Report = 33559
    function loop_unchecked_ppi() public {
        unchecked {
            for (uint256 i = 0; i < 10; ++i) {
                emit Log(i);            
            }
        }
    }
}

// Conclusion:
// loop_unchecked_ppi < loop_ppi < loop_unchecked_ipp < loop_ipp