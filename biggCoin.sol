// SPDX-License-Identifier: GPL-3.0
pragma solidity >= 0.6.0 < 0.9.0;

contract BiggCoin {
    address public owner; //creates a function dynamically to get the owners address
    mapping (address => uint) public balances; //create a virtual hash table and acess the balance

    event TransactionSuccess(address from, address to, uint amountSent); //similar to webhook
    error InsufficientFunds(uint requested, uint availableBalance); // error with more info provided

    constructor() { //called only once
        owner = msg.sender; //assign the wallet address to the owner
    }

    function mint(address etherAddress, uint amountToMint) public { //send an amount of newly created coin to another address
        require(msg.sender == owner); // make sure the minter is the one minting the coin
        balances[etherAddress] += amountToMint; // adds the amount minted to the address
    }

    function sendCoin(address receiver, uint amountToSend) public { //send coin from your  wallet available balance to an external address
        if(amountToSend > balances[msg.sender]) //check for insufficient fund
            revert InsufficientFunds({ // if true throw error with more info stating why it occured
                requested: amountToSend,
                availableBalance: balances[msg.sender]
            });
        
        //else deduct from the sender balance and add to the reciever balance
        balances[msg.sender] -= amountToSend; 
        balances[receiver] += amountToSend;

        //emit the success event
        emit TransactionSuccess(msg.sender, receiver, amountToSend);
    }
}