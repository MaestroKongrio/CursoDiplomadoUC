pragma solidity ^0.8;

contract ProofOfExistence {
    
    mapping(bytes32=>uint) public proofs;
    
    function addHash(bytes32 _hash) public {
        require(proofs[_hash]==0,"Hash ya agregado");
        proofs[_hash] = block.number;
    }
    
}
