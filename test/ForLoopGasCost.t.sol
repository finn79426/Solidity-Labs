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

    function test_loop_unchecked_ipp() public {
        ForLoopGasCost forLoop = new ForLoopGasCost();
        forLoop.loop_unchecked_ipp();
    }

    function test_loop_unchecked_ppi() public {
        ForLoopGasCost forLoop = new ForLoopGasCost();
        forLoop.loop_unchecked_ppi();
    }
}
