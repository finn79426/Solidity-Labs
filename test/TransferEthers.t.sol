// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import {Test, console} from "forge-std/Test.sol";
import {Sender} from "../src/TransferEthers.sol";

contract SenderTest is Test  {
    Sender sender;
    function setUp() public {
        sender = new Sender();
        vm.deal(address(sender), 100 ether);
    }

    function test_transfer() public {
        sender.transfer(address(makeAddr("foobar")));
    }

    function test_send() public {
        sender.send(address(makeAddr("foobar")));
    }

    function test_call() public {
        sender.call(address(makeAddr("foobar")));
    }
    
    function test_callWithSuc() public {
        sender.callWithSuc(address(makeAddr("foobar")));
    }

    function test_callWithData() public {
        sender.callWithData(address(makeAddr("foobar")));
    }

    function test_yulWithoutReturnData() public {
        sender.yulWithoutReturnData(address(makeAddr("foobar")));
    }
}


// >>> forge test
// [PASS] test_call() (gas: 45178)
// [PASS] test_callWithData() (gas: 45125)
// [PASS] test_callWithSuc() (gas: 45054)
// [PASS] test_send() (gas: 44891)
// [PASS] test_transfer() (gas: 44914)
// [PASS] test_yulWithoutReturnData() (gas: 44902)