// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import {Test, console} from "forge-std/Test.sol";
import {DEX, Token, Placeholder} from "../src/CircularDependency.sol";
import {CREATE3} from "lib/solmate/src/utils/CREATE3.sol";


contract CircularDependencyTest is Test {
    address deployer;

    function setUp() public {
        deployer = makeAddr("deployer");

        // Assume the deployer has not initiated any transactions yet
        vm.setNonce(deployer, 0);
    }


    function testCreateNewContractAddressShouldBePredictable() public {
        // expectedNewContractAddress = keccak256(rlp([sender, nonce]))[12:]
        address expected_addr = (address(uint160(uint256(keccak256(abi.encodePacked(
            bytes1(0xd6), // RLP encoding: list prefix
            bytes1(0x94), // RLP encoding: address length (20 bytes)
            deployer,
            bytes1(0x80)  // RLP encoding: nonce 0
        ))))));

        // Create contract via `CREATE`
        vm.prank(deployer); 
        Placeholder placeholder = new Placeholder(); // address(placeholder) = 0x8Ad159a275AEE56fb2334DBb69036E9c7baCEe9b

        assertEq(expected_addr, address(placeholder), "Address should be match");
    }

    function testCreateCircularDependentContractsViaCreate() public {
        address expectedDEXAddress = (address(uint160(uint256(keccak256(abi.encodePacked(
            bytes1(0xd6), // RLP encoding: list prefix
            bytes1(0x94), // RLP encoding: address length (20 bytes)
            deployer,
            bytes1(0x80)  // RLP encoding: nonce 0
        ))))));

        address expectedTokenAddress = (address(uint160(uint256(keccak256(abi.encodePacked(
            bytes1(0xd6), // RLP encoding: list prefix
            bytes1(0x94), // RLP encoding: address length (20 bytes)
            deployer,
            bytes1(0x01)  // RLP encoding: nonce 1
        ))))));

        // Create circular dependent contracts via `CREATE`
        vm.startPrank(deployer);
        DEX dex = new DEX(expectedTokenAddress);
        Token token = new Token(expectedDEXAddress);
        vm.stopPrank();

        // Check the created contract address is equal to the expected address
        assertEq(address(dex), expectedDEXAddress, "DEX address should be match");
        assertEq(address(token), expectedTokenAddress, "Token address should be match");
    }

    // This is how `CREATE3` works:
    //
    // [Create3Factory Contract] (In this case, it's address(this))
    //     |
    //     |  (CREATE2 with salt)
    //     v
    // [CREATE2 Proxy Contract]
    //     |
    //     |  (CREATE target contract with nonce=1)
    //     v
    // [YourContract @ predictable address]

    function testCreate3() public {
        // ------------------------------------------------------------------
        //                Setting salt (for CREATE2->Proxy)
        // ------------------------------------------------------------------
        bytes32 saltDEX = keccak256("salt for deploying DEX contract");
        bytes32 saltToken = keccak256("salt for deploying Token contract");

        // ------------------------------------------------------------------
        //                  Calculating expected addresses
        // ------------------------------------------------------------------
        address expectedDEXCreate2ProxyAddr = address(
            uint160(
                uint256(
                keccak256(
                    abi.encodePacked(
                    hex'ff',
                    address(this),
                    saltDEX,
                    bytes32(0x21c35dbe1b344a2488cf3321d6ce542f8e9f305544ff09e4993a62319a497c1f) // https://github.com/transmissions11/solmate/blob/main/src/utils/CREATE3.sol#L35
                    )
                )
                )
            )
        );

        address expectedTokenCreate2ProxyAddr = address(
            uint160(
                uint256(
                keccak256(
                    abi.encodePacked(
                    hex'ff',
                    address(this),
                    saltToken,
                    bytes32(0x21c35dbe1b344a2488cf3321d6ce542f8e9f305544ff09e4993a62319a497c1f) // https://github.com/transmissions11/solmate/blob/main/src/utils/CREATE3.sol#L35
                    )
                )
                )
            )
        );

        address expectedDexAddr = address(
            uint160(
                uint256(
                keccak256(
                    abi.encodePacked(
                    hex"d6_94",
                    expectedDEXCreate2ProxyAddr,
                    hex"01"
                    )
                )
                )
            )
        );

        address expectedTokenAddr = address(
            uint160(
                uint256(
                keccak256(
                    abi.encodePacked(
                    hex"d6_94",
                    expectedTokenCreate2ProxyAddr,
                    hex"01"
                    )
                )
                )
            )
        );

        // ------------------------------------------------------------------
        //         Deploy circular dependent contracts via CREATE3
        // ------------------------------------------------------------------
        address dexAddress = CREATE3.deploy(
            saltDEX,
            abi.encodePacked(
                type(DEX).creationCode,
                abi.encode(expectedTokenAddr) // constructor arguments
            ), 
        0);

        address tokenAddress = CREATE3.deploy(
            saltToken,
            abi.encodePacked(
                type(Token).creationCode,
                abi.encode(expectedDexAddr) // constructor arguments
            ), 
        0);
    
        // ------------------------------------------------------------------
        
        assertEq(expectedDexAddr, dexAddress, "DEX address should be match");
        assertEq(expectedTokenAddr, tokenAddress, "Token address should be match");
    }
}



