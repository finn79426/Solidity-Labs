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

- [CircularDependency.sol](src/CircularDependency.sol)
- [CircularDependency.t.sol](test/CircularDependency.t.sol)