// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {Test, console} from "forge-std/Test.sol";
import {Calculator} from "../src/DelegatecallLibraryExternalFunction.sol";

contract CalculatorTest is Test {
    Calculator public calculator;

    function setUp() public {
        calculator = new Calculator();
    }

    function testDouble() public {
        uint256 input = 21;
        uint256 result = calculator.getDouble(input);
        assertEq(result, 42, "Double function did not return expected value");
    }
}

// ╰─ forge test test/DelegatecallLibraryExternalFunction.t.sol -vvvvv
// Traces:
//   [140473] CalculatorTest::setUp()
//     ├─ [102951] → new Calculator@0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f
//     │   └─ ← [Return] 514 bytes of code
//     └─ ← [Stop] 

//   [13574] CalculatorTest::testDouble()
//     ├─ [4507] Calculator::getDouble(21) [staticcall]
//     │   ├─ [803] MathLib::double(21) [delegatecall]
//     │   │   └─ ← [Return] 42
//     │   └─ ← [Return] 42
//     ├─ [0] VM::assertEq(42, 42, "Double function did not return expected value") [staticcall]
//     │   └─ ← [Return] 
//     └─ ← [Stop] 