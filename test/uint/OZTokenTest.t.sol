// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {DeployOZToken} from "../../script/DeployOZToken.s.sol";
import {OZToken} from "../../src/OZToken.sol";

contract OZTokenTest is Test {
    OZToken public oZToken;
    DeployOZToken public deployerOZToken;

    address aiko = makeAddr("aiko");
    address bavy = makeAddr("bavy");

    uint256 public constant STARTING_BALANCE = 100 ether;

    function setUp() public {
        deployerOZToken = new DeployOZToken();
        oZToken = deployerOZToken.run();

        vm.prank(address(msg.sender));
        oZToken.transfer(aiko, STARTING_BALANCE);
    }

    function testAikoBalance() public view {
        assertEq(STARTING_BALANCE, oZToken.balanceOf(aiko));
    }

    function testAllowencesWorks() public {
        uint256 initialAllowence = 1000;

        // Aiko approves Bavy to spend tokens on her behalf
        vm.prank(aiko);
        oZToken.approve(bavy, initialAllowence);

        uint256 transferAmount = 500;

        vm.prank(bavy);
        oZToken.transferFrom(aiko, bavy, transferAmount);

        assertEq(oZToken.balanceOf(bavy), transferAmount);
        assertEq(oZToken.balanceOf(aiko), (STARTING_BALANCE - transferAmount));
        assert(transferAmount <= initialAllowence);
    }

    function testInitialSupply() public view {
        uint256 initialSupply = deployerOZToken.INITAL_SUPPLY();

        assertEq(
            oZToken.totalSupply(),
            initialSupply,
            "Initial supply mismatch"
        );
    }
}
