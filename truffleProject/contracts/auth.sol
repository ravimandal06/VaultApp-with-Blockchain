pragma solidity >=0.5.8;

contract AuthContract {
    struct User {
        string name;
        string email;
        string passwordHash; // For simplicity, store the password hash
    }

    mapping(address => User) public users;

    event UserRegistered(
        address indexed userAddress,
        string name,
        string email
    );
    event UserLoggedIn(address indexed userAddress);

    function registerUser(
        string memory _name,
        string memory _email,
        string memory _passwordHash
    ) public {
        users[msg.sender] = User(_name, _email, _passwordHash);
        emit UserRegistered(msg.sender, _name, _email);
    }

    function loginUser(
        string memory _email,
        string memory _passwordHash
    ) public view returns (bool) {
        address userAddress = msg.sender;
        User storage user = users[userAddress];
        return
            keccak256(abi.encodePacked(user.email)) ==
            keccak256(abi.encodePacked(_email)) &&
            keccak256(abi.encodePacked(user.passwordHash)) ==
            keccak256(abi.encodePacked(_passwordHash));
    }
}
