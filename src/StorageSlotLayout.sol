// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SlotQuiz {
    uint128 public a = 1;                   // Slot0 - 0x00000000000000000000000000000000000000000000000000000000000000001
    address public b = address(0x1234);     // Slot1 - 0x0000000000000000000000010000000000000000000000000000000000001234
    bool public c = true;   
    uint256 public d = 10;                  // Slot2 - 0x0000000000000000000000000000000000000000000000000000000000000000a
    uint256[] public e;                     // Slot3 - 0x00000000000000000000000000000000000000000000000000000000000000000 (value is the size of array, currently 0)
    uint256 public constant f = 42;         // Constant does not occupy storage slot
    uint256 immutable public g;             // Immutable does not occupy storage slot

    // Define a struct does not occupy storage slot, until it is used in a state variable
    struct Struct {
        uint128 x;                          // 16 bytes
        uint256 y;                          // 32 bytes
        bool z;                             // 1 byte
        uint8 i;                            // 1 byte
    }
    
    Struct public structVar;                       // Slot4(x) + Slot5(y) + Slot6(z,w)

    mapping(string => string) public h;   // Slot6 - 0x00000000000000000000000000000000000000000000000000000000000000000 (occupies a slot but no value will be in there)
    
    constructor() {
        g = 999;
    }

    function setArrayLength(uint256 _length) public {
        e = new uint256[](_length);
    }

    function setStructValue(uint128 _x, uint256 _y, bool _z, uint8 _i) public {
        structVar.x = _x;
        structVar.y = _y;
        structVar.z = _z;
        structVar.i = _i;
    }

    function setMappingValue(string calldata _key, string calldata _value) public {
        h[_key] = _value;
    }
}