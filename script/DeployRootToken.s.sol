// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {Script} from "forge-std/Script.sol";
import {RootToken} from "../src/RootToken.sol";

contract DeployRootToken is Script {
    function run() external returns (RootToken) {
        vm.startBroadcast();
        RootToken rootToken = new RootToken();
        vm.stopBroadcast();
        return rootToken;
    }
}
