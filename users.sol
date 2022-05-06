contract UserData{
    string name;

    function GetUserName() public view returns (string memory) {
        return name;
    }
}