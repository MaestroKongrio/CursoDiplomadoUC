pragma solidity ^0.8;

contract Splitter {
    
    address public beneficiario1;
    address public beneficiario2;
    
    modifier onlyDireccionesDistintas {
        require(_ben1 != _ben2,"Las direcciones no puede ser iguales");
        _;
    }
    
    constructor(address _ben1, address _ben2) onlyDireccionesDistintas {
        beneficiario1= _ben1;
        beneficiario2= _ben2;
    }
    
    function split() payable public {
        payable(beneficiario1).transfer(msg.value/2);
        payable(beneficiario2).transfer(msg.value/2);
    }
}
