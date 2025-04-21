# Solidity-Labs

## For Loop Gas Cost

This experimental script shows how different loop implementations affect gas consumption.

```
1. i++ => 33653
2. ++i => 33625
3. unchecked {i++} => 33631
4. unchecked {++i} => 33559

Conclusion: 4 < 2 < 3 < 1
```

- [ForLoopGasCost.sol](src/ForLoopGasCost.sol)
- [ForLoopGasCost.t.sol](test/ForLoopGasCost.t.sol)

# Transfer Ethers

This experimental script shows how different transfer ETH methods affect gas consumption.

```
1. transfer() => 56264
2. send() => 56263
3. call() => 56551
4. call() with storing bool return value => 56492
5. call() with storing bool+bytes return values => 56521
6. yul assembly without storing any return values => 56267

Conclusion: 2 < 1 < 6 < 4 < 5 < 3
```

- [TransferEthers.sol](src/TransferEthers.sol)
- [TransferEthers.t.sol](test/TransferEthers.t.sol)

# Circular Dependency

This experimental script shows how circularly dependent contracts can be deployed via `CREATE` and `CREATE3`, inspired by [Secureum RACE#35 Question 4](https://ventral.digital/posts/2024/12/10/race-35-of-the-secureum-bootcamp-epoch-infinity/#question-4-of-8).

```
Deploy Circular Dependent Contracts:

✅ CREATE: New Contract Address = keccak256(rlp.encode([deployer_address, nonce]))[-20:]
Deployer's nonce is predictable, therefore, the New Contract Address is also predictable.

❎ CREATE2: New Contract Address = keccak256(0xff ++ deployer_address ++ salt ++ keccak256(init_code))[-20:]
The init_code including the constructor and its arguments, therefore, in this case, the new contract address is unpredictable.

✅ CREATE3: New Contract Address = keccak256(rlp.encode([proxy_address, nonce]))[-20:]
proxy_address = keccak256(0xff ++ deployer_address ++ salt ++ keccak256(proxy_init_code))[-20:]
In this case, proxy_init_code is pre-defined fixed bytecode (no dynamic constructor involved). Therefore, the proxy_address is predictable.
Since proxy_address is predictable, the contract address CREATED by proxy is also predictable.
```

- [CircularDependency.sol](src/CircularDependency.sol)
- [CircularDependency.t.sol](test/CircularDependency.t.sol)

# Storage Slot Layout

Just a lab for learning smart contract storage layout.

- [StorageSlotLayout.sol](src/StorageSlotLayout.sol)
- [StorageSlotLayout.t.sol](test/StorageSlotLayout.t.sol)

# Delegatecall Library's External Function

Used to prove that a delegate call is used when calling the library's external function, inspired by [Secureum RACE#34 Question 3](https://ventral.digital/posts/2024/11/10/race-34-of-the-secureum-bootcamp-epoch-infinity/#question-3-of-8).

- [DelegatecallLibraryExternalFunction.sol](src/DelegatecallLibraryExternalFunction.sol)
- [DelegatecallLibraryExternalFunction.t.sol](test/DelegatecallLibraryExternalFunction.t.sol)