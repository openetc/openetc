# OpenETC

<img src="https://raw.githubusercontent.com/ethereumclassic/Media_Kit/master/Button_Powered_by_ETC/powered_by_etc_button_white.png" width="40%">

Fast and feature-rich multi-network [Ethereum Classic](https://ethereumclassic.org) client.

This project is a fork of [openethereum/openethereum](https://github.com/openethereum/openethereum). The maintainer of OpenEthereum client [dropped support for Ethereum Classic](https://github.com/openethereum/openethereum/pull/11821), which we intend to keep.

[» Download the latest release «](https://github.com/openetc/openetc/releases/latest)

[![GPL licensed][license-badge]][license-url]
[![Build Status][ci-badge]][ci-url]
[![Discord chat][chat-badge]][chat-url]

[license-badge]: https://img.shields.io/badge/license-GPL_v3-green.svg
[license-url]: LICENSE
[ci-badge]: https://github.com/openetc/openetc/workflows/Build%20and%20Test%20Suite/badge.svg
[ci-url]: https://github.com/openetc/openetc/actions
[chat-badge]: https://img.shields.io/discord/734474532295016559.svg?logo=discord
[chat-url]: https://discord.gg/4PyGtp7

## Table of Contents

1. [Description](#chapter-001)
2. [Technical Overview](#chapter-002)
3. [Building](#chapter-003)<br>
  3.1 [Building Dependencies](#chapter-0031)<br>
  3.2 [Building from Source Code](#chapter-0032)<br>
  3.3 [Starting OpenETC](#chapter-0034)
4. [Testing](#chapter-004)
5. [Documentation](#chapter-005)
6. [Toolchain](#chapter-006)
7. [Contributing](#chapter-008)
8. [License](#chapter-009)


## 1. Description <a id="chapter-001"></a>

**Built for mission-critical use**: Miners, service providers, and exchanges need fast synchronisation and maximum uptime. OpenETC provides the core infrastructure essential for speedy and reliable services.

- Ethereum Classic support
- Clean, modular codebase for easy customisation
- Advanced CLI-based client
- Minimal memory and storage footprint
- Synchronise in hours, not days with Warp Sync
- Modular for light integration into your service or product

## 2. Technical Overview <a id="chapter-002"></a>

OpenETC's goal is to be the fastest, lightest, and most secure Ethereum Classic client. We are developing OpenETC using the **Rust programming language**. OpenETC is licensed under the GPLv3 and can be used for all your Ethereum Classic needs.

By default, OpenETC runs a JSON-RPC HTTP server on port `:8545` and a Web-Sockets server on port `:8546`. This is fully configurable and supports a number of APIs.

If you run into problems while using OpenETC, check out the [old wiki for documentation](https://wiki.parity.io/), feel free to [file an issue in this repository](https://github.com/openetc/openetc/issues/new), or hop on our [Discord](https://discord.gg/4PyGtp7) chat room to ask a question. We are glad to help!

You can download OpenETC's latest release at [the releases page](https://github.com/openetc/openetc/releases) or follow the instructions below to build from source. Read the [CHANGELOG.md](CHANGELOG.md) for a list of all changes between different versions.

## 3. Building <a id="chapter-003"></a>

### 3.1 Build Dependencies <a id="chapter-0031"></a>

OpenETC requires **latest stable Rust version** to build.

We recommend installing Rust through [rustup](https://www.rustup.rs/). If you don't already have `rustup`, you can install it like this:

- Linux:
  ```bash
  $ curl https://sh.rustup.rs -sSf | sh
  ```

  OpenETC also requires `clang` (>= 9.0), `clang++`, `pkg-config`, `file`, `make`, and `cmake` packages to be installed.

- OSX:
  ```bash
  $ curl https://sh.rustup.rs -sSf | sh
  ```

  `clang` is required. It comes with Xcode command line tools or can be installed with homebrew.

- Windows:
  Make sure you have Visual Studio 2015 with C++ support installed. Next, download and run the `rustup` installer from
  https://static.rust-lang.org/rustup/dist/x86_64-pc-windows-msvc/rustup-init.exe, start "VS2015 x64 Native Tools Command Prompt", and use the following command to install and set up the `msvc` toolchain:
  ```bash
  $ rustup default stable-x86_64-pc-windows-msvc
  ```

Once you have `rustup` installed, then you need to install:
* [Perl](https://www.perl.org)
* [Yasm](https://yasm.tortall.net)

Make sure that these binaries are in your `PATH`. After that, you should be able to build OpenETC from source.

### 3.2 Build from Source Code <a id="chapter-0032"></a>

```bash
# download OpenETC code
$ git clone https://github.com/openetc/openetc
$ cd openetc

# build in release mode
$ cargo build --release --features final
```

This produces an executable in the `./target/release` subdirectory.

Note: if cargo fails to parse manifest try:

```bash
$ ~/.cargo/bin/cargo build --release
```

Note, when compiling a crate and you receive errors, it's in most cases your outdated version of Rust, or some of your crates have to be recompiled. Cleaning the repository will most likely solve the issue if you are on the latest stable version of Rust, try:

```bash
$ cargo clean
```

This always compiles the latest nightly builds. If you want to build stable, do a

```bash
$ git checkout stable
```

### 3.3 Starting OpenETC <a id="chapter-0034"></a>

#### Manually

To start OpenETC manually, just run

```bash
$ ./target/release/openetc
```

so OpenETC begins syncing the Ethereum Classic blockchain.

#### Using `systemd` service file

To start OpenETC as a regular user using `systemd` init:

1. Copy `./scripts/openetc.service` to your
`systemd` user directory (usually `~/.config/systemd/user`).
2. Copy release to bin folder, write `sudo install ./target/release/openetc /usr/bin/openetc`
3. To configure OpenETC, see [our old wiki](https://paritytech.github.io/wiki/Configuring-Parity) for details.

## 4. Testing <a id="chapter-004"></a>

Download the required test files: `git submodule update --init --recursive`. You can run tests with the following commands:

* **All** packages
  ```
  cargo test --all
  ```

* Specific package
  ```
  cargo test --package <spec>
  ```

Replace `<spec>` with one of the packages from the [package list](#package-list) (e.g. `cargo test --package evmbin`).

You can show your logs in the test output by passing `--nocapture` (i.e. `cargo test --package evmbin -- --nocapture`)

## 5. Documentation <a id="chapter-005"></a>

Be sure to [check out our old wiki](https://wiki.parity.io) for more information.

### Viewing documentation for OpenETC packages

You can generate documentation for OpenETC Rust packages that automatically opens in your web browser using [rustdoc with Cargo](https://doc.rust-lang.org/rustdoc/what-is-rustdoc.html#using-rustdoc-with-cargo) (of the The Rustdoc Book), by running the the following commands:

* **All** packages
  ```
  cargo doc --document-private-items --open
  ```

* Specific package
  ```
  cargo doc --package <spec> -- --document-private-items --open
  ```

Use`--document-private-items` to also view private documentation and `--no-deps` to exclude building documentation for dependencies.

Replacing `<spec>` with one of the following from the details section below (i.e. `cargo doc --package openetc --open`):

<a id="package-list"></a>
**Package List**
<details><p>

* OpenETC Client Application
  ```bash
  openetc
  ```
* OpenETC Account Management, Key Management Tool, and Keys Generator
  ```bash
  ethcore-accounts, ethkey-cli, ethstore, ethstore-cli
  ```
* OpenETC Chain Specification
  ```bash
  chainspec
  ```
* OpenETC CLI Signer Tool & RPC Client
  ```bash
  cli-signer parity-rpc-client
  ```
* OpenETC Ethash & ProgPoW Implementations
  ```bash
  ethash
  ```
* EthCore Library
  ```bash
  ethcore
  ```
  * OpenETC Blockchain Database, Test Generator, Configuration,
Caching, Importing Blocks, and Block Information
    ```bash
    ethcore-blockchain
    ```
  * OpenETC Contract Calls and Blockchain Service & Registry Information
    ```bash
    ethcore-call-contract
    ```
  * OpenETC Database Access & Utilities, Database Cache Manager
    ```bash
    ethcore-db
    ```
  * OpenETC Virtual Machine (EVM) Rust Implementation
    ```bash
    evm
    ```
  * OpenETC Light Client Implementation
    ```bash
    ethcore-light
    ```
  * Smart Contract based Node Filter, Manage Permissions of Network Connections
    ```bash
    node-filter
    ```
  * Private Transactions
    ```bash
    ethcore-private-tx
    ```
  * OpenETC Client & Network Service Creation & Registration with the I/O Subsystem
    ```bash
    ethcore-service
    ```
  * OpenETC Blockchain Synchronization
    ```bash
    ethcore-sync
    ```
  * OpenETC Common Types
    ```bash
    common-types
    ```
  * OpenETC Virtual Machines (VM) Support Library
    ```bash
    vm
    ```
  * OpenETC WASM Interpreter
    ```bash
    wasm
    ```
  * OpenETC WASM Test Runner
    ```bash
    pwasm-run-test
    ```
  * OpenETC EVM Implementation
    ```bash
    evmbin
    ```
  * OpenETC JSON Deserialization
    ```bash
    ethjson
    ```
  * OpenETC State Machine Generalization for Consensus Engines
    ```bash
    parity-machine
    ```
* OpenETC Miner Interface
  ```bash
  ethcore-miner parity-local-store price-info ethcore-stratum using_queue
  ```
* OpenETC Logger Implementation
  ```bash
  ethcore-logger
  ```
* OpenETC JSON-RPC Servers
  ```bash
  parity-rpc
  ```
* OpenETC Updater Service
  ```bash
  parity-updater parity-hash-fetch
  ```
* OpenETC Core Libraries (`util`)
  ```bash
  accounts-bloom blooms-db dir eip-712 fake-fetch fastmap fetch ethcore-io
  journaldb keccak-hasher len-caching-lock memory-cache memzero
  migration-rocksdb ethcore-network ethcore-network-devp2p panic_hook
  patricia-trie-ethereum registrar rlp_compress stats
  time-utils triehash-ethereum unexpected parity-version
  ```

</p></details>

## 6. Toolchain <a id="chapter-006"></a>

In addition to the OpenETC client, there are additional tools in this repository available:

- [evmbin](./evmbin) - OpenETC EVM Implementation.
- [ethstore](./accounts/ethstore) - OpenETC Key Management.
- [ethkey](./accounts/ethkey) - OpenETC Keys Generator.

The following tools are available in a separate repository:
- [ethabi](https://github.com/openetc/ethabi) - OpenETC Encoding of Function Calls. [Docs here](https://crates.io/crates/ethabi)
- [whisper](https://github.com/openetc/whisper) - OpenETC Whisper-v2 PoC Implementation.

## 7. Contributing <a id="chapter-007"></a>

An introduction has been provided in the ["So You Want to be a Core Developer" presentation slides by Hernando Castano](http://tiny.cc/contrib-to-parity-eth). Additional guidelines are provided in [CONTRIBUTING](./.github/CONTRIBUTING.md).

### Contributor Code of Conduct

[CODE_OF_CONDUCT](./.github/CODE_OF_CONDUCT.md)

## 8. License <a id="chapter-008"></a>

[LICENSE](./LICENSE)
