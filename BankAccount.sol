// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract BankAccount {
    mapping(address => uint256) private balances;

    function deposit() external payable {
        require(msg.value > 0, "Deposit must be positive");
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) external {
        require(amount > 0, "Withdrawal must be positive");
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] -= amount;
        (bool sent, ) = payable(msg.sender).call{value: amount}("");
        require(sent, "Ether transfer failed");
    }

    function getBalance() external view returns (uint256) {
        return balances[msg.sender];
    }

    receive() external payable {}

    fallback() external payable {}
}
