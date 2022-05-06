// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract UserData{
    string name;

    function getUserName() public view returns (string memory) {
        return name;
    }

    // set the username for the user with value of the arg - username
    function setUserName(string memory username) public {
        name = username;
    }
}