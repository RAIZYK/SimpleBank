// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/Bank.sol";

contract DeployBank is Script {
    function run() external returns (Bank) {
        vm.startBroadcast();
        Bank bank = new Bank();
        vm.stopBroadcast();
        return bank;
    }
}
