// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import {Test, console} from "forge-std/Test.sol";
import {SlotQuiz} from "../src/StorageSlotLayout.sol";

contract SlotQuizTest is Test {
    SlotQuiz slotQuiz;

    function setUp() public {
        slotQuiz = new SlotQuiz();
    }


    function testSlot0() public {
        bytes32 slot0 = vm.load(address(slotQuiz), 0);
        assertEq(slot0, bytes32(0x0000000000000000000000000000000000000000000000000000000000000001));
    }

    function testSlot1() public {
        bytes32 slot1 = vm.load(address(slotQuiz), bytes32(uint256(1)));
        assertEq(slot1, bytes32(0x0000000000000000000000010000000000000000000000000000000000001234));
    }

    function testSlot2() public {
        bytes32 slot2 = vm.load(address(slotQuiz), bytes32(uint256(2)));
        assertEq(slot2, bytes32(0x000000000000000000000000000000000000000000000000000000000000000a));
    }

    function testSlot3() public {
        bytes32 slot3 = vm.load(address(slotQuiz), bytes32(uint256(3)));
        assertEq(slot3, bytes32(0x00000000000000000000000000000000000000000000000000000000000000000));

        // Change the size of the dynamic array 
        slotQuiz.setArrayLength(15);
        slot3 = vm.load(address(slotQuiz), bytes32(uint256(3)));

        // The value of the Slot3 became the size of the array
        assertEq(slot3, bytes32(0x000000000000000000000000000000000000000000000000000000000000000f));
    }

    function testSlot456() public {
        bytes32 slot4 = vm.load(address(slotQuiz), bytes32(uint256(4)));
        bytes32 slot5 = vm.load(address(slotQuiz), bytes32(uint256(5)));
        bytes32 slot6 = vm.load(address(slotQuiz), bytes32(uint256(6)));
        assertEq(slot4, bytes32(0x00000000000000000000000000000000000000000000000000000000000000000));
        assertEq(slot5, bytes32(0x00000000000000000000000000000000000000000000000000000000000000000));
        assertEq(slot6, bytes32(0x00000000000000000000000000000000000000000000000000000000000000000));

        // Set the value of the struct
        slotQuiz.setStructValue(15, 30, true, 45);

        // Slot 4, 5 and 6 should now have values
        slot4 = vm.load(address(slotQuiz), bytes32(uint256(4)));
        slot5 = vm.load(address(slotQuiz), bytes32(uint256(5)));
        slot6 = vm.load(address(slotQuiz), bytes32(uint256(6)));
        assertEq(slot4, bytes32(0x000000000000000000000000000000000000000000000000000000000000000f));
        assertEq(slot5, bytes32(0x000000000000000000000000000000000000000000000000000000000000001e));
        assertEq(slot6, bytes32(0x0000000000000000000000000000000000000000000000000000000000002d01));
    }

    function testSlot7() public {
        bytes32 slot7 = vm.load(address(slotQuiz), bytes32(uint256(7)));
        assertEq(slot7, bytes32(0x0000000000000000000000000000000000000000000000000000000000000000));


        // Set the key-value of the mapping
        slotQuiz.setMappingValue("dog", "woof");
        slotQuiz.setMappingValue("superlong", "suuuuuuuppppppppeerlogggggggggggggggg"); // value size > 31 bytes

        // Slot 7 should still be empty
        slot7 = vm.load(address(slotQuiz), bytes32(uint256(7)));
        assertEq(slot7, bytes32(0x0000000000000000000000000000000000000000000000000000000000000000));

        // the "woof" stored at `keccak256(key, 7)` 
        bytes32 slotValue1 = vm.load(address(slotQuiz), keccak256(abi.encodePacked("dog", uint256(7))));
        assertEq(slotValue1, bytes32(0x776f6f6600000000000000000000000000000000000000000000000000000008));

        bytes32 slotValue2 = vm.load(address(slotQuiz), keccak256(abi.encodePacked("superlong", uint256(7))));
        assertEq(slotValue2, bytes32(0x000000000000000000000000000000000000000000000000000000000000004b)); // this represents the size of the data length == 75 bytes >> 1 == 37 == len("suuuuuuuppppppppeerlogggggggggggggggg")


        bytes32 slotKey = keccak256(abi.encodePacked("superlong", uint256(7)));
        bytes32 slotDataStart = keccak256(abi.encodePacked(slotKey));

        bytes32 part1 = vm.load(address(slotQuiz), slotDataStart);
        bytes32 part2 = vm.load(address(slotQuiz), bytes32(uint256(slotDataStart) + 1));
        bytes32 part3 = vm.load(address(slotQuiz), bytes32(uint256(slotDataStart) + 2));

        assertEq(part1, bytes32(0x737575757575757570707070707070706565726c6f6767676767676767676767)); // suuuuuuuppppppppeerloggggggggggg
        assertEq(part2, bytes32(0x6767676767000000000000000000000000000000000000000000000000000000)); // ggggg
        assertEq(part3, bytes32(0x0000000000000000000000000000000000000000000000000000000000000000));

    }
}
