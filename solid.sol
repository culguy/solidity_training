// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Solid {
    address public tosin;
    mapping (address => uint) public balances;

    event sent(address from, address to, uint amount);

    constructor() {
        tosin = msg.sender;
    }

    function mint(address receiver, uint amount) public {
        require(msg.sender == tosin);
        balances[receiver] += amount;
    }

    error InsufficientBalance(uint requested, uint available );

    function send(address receiver, uint amount) public {
        if (amount > balances[msg.sender])
            revert InsufficientBalance({
                requested: amount,
                availabe: balances[msg.sender]
            });
        
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit sent(msg.sender, receiver, amount);
    }
}