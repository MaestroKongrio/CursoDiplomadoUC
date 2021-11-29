pragma solidity ^0.8;

contract ProofOfExistence {
    
    uint public bloque;
    bytes32 public hash;
    
    constructor(bytes32 _hash) {
        hash = _hash;
        bloque= block.number;
    }
    
}
