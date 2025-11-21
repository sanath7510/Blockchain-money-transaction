// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MoneyTransactionSecurity {

    struct Transaction {
        address from;
        address to;
        int amount;
        uint timestamp;
    }

    Transaction[] public transactions;

    mapping(address => int) public balances;

    event MoneySent(address indexed from, address indexed to, int amount, uint timestamp);

    constructor() {
        // Give demo users some initial balance
        balances[msg.sender] = 1000;
    }

    function sendMoney(address _to, int _amount) public {
        require(_amount > 0, "Amount must be positive");
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        require(_to != address(0), "Invalid address");

        // Deduct and Add
        balances[msg.sender] -= _amount;
        balances[_to] += _amount;

        // Save transaction
        transactions.push(Transaction(msg.sender, _to, _amount, block.timestamp));

        emit MoneySent(msg.sender, _to, _amount, block.timestamp);
    }

    function getTransaction(uint index) public view returns (Transaction memory) {
        require(index < transactions.length, "Invalid index");
        return transactions[index];
    }

    function totalTransactions() public view returns (uint) {
        return transactions.length;
    }
}
