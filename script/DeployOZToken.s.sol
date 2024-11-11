// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {Script} from "forge-std/Script.sol";
import {OZToken} from "../src/OZToken.sol";

contract DeployOZToken is Script {
    uint256 public constant INITAL_SUPPLY = 10000 ether;

    function run() external returns (OZToken) {
        vm.startBroadcast();
        OZToken oZ = new OZToken(INITAL_SUPPLY);
        vm.stopBroadcast();
        return oZ;
    }
}
