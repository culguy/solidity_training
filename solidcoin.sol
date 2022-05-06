// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract SolidCoin {
    address public tosin;
    mapping (address => uint) public balances;

    event TranssactionSuccessful(address sender, address receiver, uint amount);

    constructor() {
        tosin = msg.sender;
    }

    function mint(address receiver, uint amount) public {
        require(msg.sender == tosin);
        balances[receiver] += amount;
    }

    error TransactionFailed(uint amountrequested, uint amountavailable );

    function send(address receiver, uint amount) public {
        if (amount > balances[msg.sender])
            revert TransactionFailed({
                amountrequested: amount,
                amountavailable: balances[msg.sender]
            });
        
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit TranssactionSuccessful(msg.sender, receiver, amount);
    }
}