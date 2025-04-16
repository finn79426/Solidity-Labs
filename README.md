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

- [CircularDependency.sol](src/ForLoopGasCost.sol)
- [CircularDependency.t.sol](test/ForLoopGasCost.t.sol)


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
- [TransferEthers.t.sol](test/TransferEthers.t.t.sol)

