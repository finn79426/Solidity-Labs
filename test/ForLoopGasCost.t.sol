// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import {Test, console} from "forge-std/Test.sol";
import {ForLoopGasCost} from "../src/ForLoopGasCost.sol";

contract ForLoopGasCostTest is Test  {

    function test_loop_ipp() public {
        ForLoopGasCost forLoop = new ForLoopGasCost();
        forLoop.loop_ipp();
    }

    function test_loop_ppi() public {
        ForLoopGasCost forLoop = new ForLoopGasCost();
        forLoop.loop_ppi();
    }
}

// ╰─ forge test ./test/ForLoopGasCost.t.sol           
// [⠊] Compiling...
// [⠑] Compiling 20 files with Solc 0.8.28
// [⠃] Solc 0.8.28 finished in 621.83ms
// Compiler run successful!
// Ran 2 tests for test/ForLoopGasCost.t.sol:ForLoopTest
// [PASS] test_loop_ipp() (gas: 114788)
// [PASS] test_loop_ppi() (gas: 114783)
// Suite result: ok. 2 passed; 0 failed; 0 skipped; finished in 4.92ms (1.80ms CPU time)
// Ran 1 test suite in 404.23ms (4.92ms CPU time): 2 tests passed, 0 failed, 0 skipped (2 total tests)


// ╰─ forge test ./test/ForLoopGasCost.t.sol --via-ir
// [⠊] Compiling...
// [⠊] Compiling 20 files with Solc 0.8.28
// [⠒] Solc 0.8.28 finished in 919.52ms
// Compiler run successful!
// Ran 2 tests for test/ForLoopGasCost.t.sol:ForLoopTest
// [PASS] test_loop_ipp() (gas: 168500)
// [PASS] test_loop_ppi() (gas: 168386)
// Suite result: ok. 2 passed; 0 failed; 0 skipped; finished in 4.52ms (1.21ms CPU time)
// Ran 1 test suite in 394.16ms (4.52ms CPU time): 2 tests passed, 0 failed, 0 skipped (2 total tests)


// ╰─ forge test ./test/ForLoopGasCost.t.sol --optimize 
// [⠊] Compiling...
// [⠘] Compiling 20 files with Solc 0.8.28
// [⠊] Solc 0.8.28 finished in 713.68ms
// Compiler run successful!
// Ran 2 tests for test/ForLoopGasCost.t.sol:ForLoopTest
// [PASS] test_loop_ipp() (gas: 80883)
// [PASS] test_loop_ppi() (gas: 80928)
// Suite result: ok. 2 passed; 0 failed; 0 skipped; finished in 4.94ms (1.91ms CPU time)
// Ran 1 test suite in 420.06ms (4.94ms CPU time): 2 tests passed, 0 failed, 0 skipped (2 total tests)


// ╰─ forge test ./test/ForLoopGasCost.t.sol --via-ir --optimize
// [⠊] Compiling...
// [⠆] Compiling 20 files with Solc 0.8.28
// [⠔] Solc 0.8.28 finished in 1.22s
// Compiler run successful!
// Ran 2 tests for test/ForLoopGasCost.t.sol:ForLoopTest
// [PASS] test_loop_ipp() (gas: 81159)
// [PASS] test_loop_ppi() (gas: 81016)
// Suite result: ok. 2 passed; 0 failed; 0 skipped; finished in 5.65ms (2.57ms CPU time)
// Ran 1 test suite in 492.00ms (5.65ms CPU time): 2 tests passed, 0 failed, 0 skipped (2 total tests)