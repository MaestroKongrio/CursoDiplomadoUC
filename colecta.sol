// SPDX-License-Identifier: MIT

pragma solidity ^0.8;

contract DemoAddress {

    uint public saldo;
    address public beneficiario;
    mapping(address=>uint) public aportes;
    uint public meta;
    bool public aportesAbiertos;
    bool public devolucionHabilitada;

    modifier onlyBeneficiario {
        require(msg.sender==beneficiario,"Solo puede llamarla el beneficiario");
        _;
    }

    modifier onlyColectaAbierta {
        require(aportesAbiertos,"La colecta esta cerrada");
        _;
    }

    constructor(uint _meta) {
        beneficiario = msg.sender;
        aportesAbiertos = true;
        meta = _meta;
        devolucionHabilitada = false;
    }

    function depositar() public payable onlyColectaAbierta {
        saldo = saldo +  msg.value;
        aportes[msg.sender]= aportes[msg.sender] + msg.value;
    }

    function retirarAporte() public {
        require(devolucionHabilitada,"Las devoluciones no estan habilitadas");
        require(aportes[msg.sender]>0,"No tiene saldo por retirar");
        payable(msg.sender).transfer(aportes[msg.sender]);
        saldo = saldo - aportes[msg.sender];
        aportes[msg.sender]=0; 
    }

    function cerrarAportes() public onlyBeneficiario onlyColectaAbierta {
        aportesAbiertos = false;
        if(saldo >= meta) {
            payable(beneficiario).transfer(saldo);
            saldo = 0;
        } else{
            devolucionHabilitada = true;
        }
    } 

}
