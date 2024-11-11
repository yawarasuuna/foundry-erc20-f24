// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract RootToken {
    mapping(address => uint256) private s_balances;

    // function name() public pure returns (string memory) {
    //     return "Root Token";
    // }

    string public name = "Root Token"; // same as above function name(), there are gas trade offs

    function symbol() public pure returns (string memory) {
        return "ROOT";
    }

    function decimals() public pure returns (uint8) {
        return 10;
    }

    function totalSupply() public pure returns (uint256) {
        return 1 ether;
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return s_balances[_owner];
    }

    function transfer(address _to, uint256 _amount) public payable {
        uint256 previousBalances = balanceOf(msg.sender) + balanceOf(_to);
        s_balances[msg.sender] -= _amount;
        s_balances[_to] += _amount;
        require(balanceOf(msg.sender) + balanceOf(_to) == previousBalances);
    }
}
