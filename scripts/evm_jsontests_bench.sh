#!/usr/bin/env bash

cargo build --release -p evmbin

./target/release/openetc-evm stats-jsontests-vm ./ethcore/res/ethereum/tests/VMTests/vmArithmeticTest
./target/release/openetc-evm stats-jsontests-vm ./ethcore/res/ethereum/tests/VMTests/vmBitwiseLogicOperation
./target/release/openetc-evm stats-jsontests-vm ./ethcore/res/ethereum/tests/VMTests/vmBlockInfoTest
./target/release/openetc-evm stats-jsontests-vm ./ethcore/res/ethereum/tests/VMTests/vmEnvironmentalInfo
./target/release/openetc-evm stats-jsontests-vm ./ethcore/res/ethereum/tests/VMTests/vmIOandFlowOperations
./target/release/openetc-evm stats-jsontests-vm ./ethcore/res/ethereum/tests/VMTests/vmLogTest
./target/release/openetc-evm stats-jsontests-vm ./ethcore/res/ethereum/tests/VMTests/vmPerformance
./target/release/openetc-evm stats-jsontests-vm ./ethcore/res/ethereum/tests/VMTests/vmPushDupSwapTest
./target/release/openetc-evm stats-jsontests-vm ./ethcore/res/ethereum/tests/VMTests/vmRandomTest
./target/release/openetc-evm stats-jsontests-vm ./ethcore/res/ethereum/tests/VMTests/vmSha3Test
./target/release/openetc-evm stats-jsontests-vm ./ethcore/res/ethereum/tests/VMTests/vmSystemOperations
./target/release/openetc-evm stats-jsontests-vm ./ethcore/res/ethereum/tests/VMTests/vmTests
