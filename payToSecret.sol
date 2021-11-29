pragma solidity ^0.8;

contract PayToSecret {
    
    bytes32 public hashedSecret;
    
    constructor(bytes32 _hashedSecret) payable {
        hashedSecret=_hashedSecret;
    }
    
    function pay(string memory secret) public {
        require(keccak256(abi.encodePacked(secret))==hashedSecret,"Secreto incorrecto");
        payable(msg.sender).transfer(address(this).balance);
    }
    
    function getHash(string memory secret) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(secret));
    }
    
}
