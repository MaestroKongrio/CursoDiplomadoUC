// SPDX-License-Identifier: MIT

pragma solidity ^0.8;

contract DemoHash {

    struct hashInfo {
        uint256 fecha;
        address creador;
    }

    mapping(bytes32=>hashInfo) public Hashes;

    function saveHash(bytes32 _hash) public {
        require(!isHashSaved(_hash),"Hash ya almacenado");
        hashInfo memory _nuevo = hashInfo(block.timestamp,msg.sender);
        Hashes[_hash] = _nuevo;
    }

    function isHashSaved(bytes32 _hash) public view returns(bool) {
        return !(Hashes[_hash].creador==address(0));
    }

    function getHash(uint _numero, string memory _string) public pure returns (bytes32) {
        return keccak256(abi.encode(_numero,_string));
    }
}
