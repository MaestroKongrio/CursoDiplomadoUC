// SPDX-License-Identifier: MIT

pragma solidity ^0.8;


contract Ownable {

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender==owner,"Solo puede llamarla el beneficiario");
        _;
    }

}

contract Pausable is Ownable {
    
    bool public paused;

    modifier WhenPaused {
        require(paused,"Solo cuando esta pausado");
        _;
    }

    modifier WhenNotPaused {
        require(!paused,"Solo cuando esta activo");
        _;
    }

    constructor() {
        paused=false;
    }

    function Pause() onlyOwner public {
        require(!paused,"Ya esta pausado");
        paused= true;
    }

    function Unpause() onlyOwner public {
        require(paused,"Ya esta activo");
        paused= false;
    }

}

contract AuthList is Ownable {

    mapping(address=>bool) private Authorized;

    modifier onlyAuthorized {
        require(isAuthorized(msg.sender),"No esta en la lista de autorizados");
        _;
    }

    function Grant(address _newAddress) public {
        require(isAuthorized(_newAddress),"Autorizacion ya entregada");
        Authorized[_newAddress] = true;
    }

    function Revoke(address _newAddress) public {
        require(!isAuthorized(_newAddress),"Autorizacion ya revocada");
        Authorized[_newAddress] = false;
    }

    function isAuthorized(address _addr) public view returns(bool) {
        return Authorized[_addr];
    }

}

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
            selfdestruct(payable(msg.sender));
        } else{
            devolucionHabilitada = true;
        }
    } 

}
