// SPDX-License-Identifier: MIT

pragma solidity ^0.8;


contract HolaMundo {
    
    string public frase;
    address public owner;
    
    constructor () {
        frase= "Hola Mundo";
        owner= msg.sender;
    }
    
    function cambiarFrase(string memory _nuevaFrase) public {
        if(msg.sender==owner) {
            frase= _nuevaFrase;
        } else {
            revert("Usted no puede hacer esto");
        }
    }

    
}
