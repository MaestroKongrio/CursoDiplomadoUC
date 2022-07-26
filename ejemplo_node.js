//se importa la libreria

const { ethers } = require("ethers");

const tokenAbi = [
    // Some details about the token
    "function name() view returns (string)",
    "function symbol() view returns (string)",
  
    // Get the account balance
    "function balanceOf(address) view returns (uint)",
  
    // Send some of your tokens to someone else
    "function transfer(address to, uint amount)",
  
    // An event triggered whenever anyone transfers to someone else
    "event Transfer(address indexed from, address indexed to, uint amount)"
  ];

  //conectese a Rinkeby usando Infura, con este endpoint
const provider = new ethers.providers.JsonRpcProvider("https://rinkeby.infura.io/v3/31704fffd0fb47f59f1ef89fa9e78523");

var wallet = new ethers.Wallet("c4b1da8b694c47d538ebec8bb20cab5ede2ad6a28381ef28058ecb51b05a78ce")
wallet= wallet.connect(provider)

const tokenContract = new ethers.Contract("0xa46e07da640e208b1452b012417af52868bf8748", tokenAbi, provider);

const obtenerBloque = async () => {
    const bloque = await provider.getBlockNumber()
    console.log(bloque)
}

const obtenerSaldo = async (cuenta) => {
    balance = await provider.getBalance(cuenta)
    console.log(balance)
    console.log(ethers.utils.formatEther(balance) + " RINKEBY Ethers")
}

const transferir =  async()=>{
     const tx = await wallet.sendTransaction({
         to: "djfas.eth",
         value: ethers.utils.parseEther("0.5")
     });
}

const bloqueTransferencia= async()=>{
    console.log("Saldo Wallet PAto")
    await obtenerSaldo("0x45d4ec5c687A7fe1cE035353e0CBF086640f373E")
    console.log("Saldo Wallet Fabian")
    await obtenerSaldo("djfas.eth")
    await transferir()
    //obtenerSaldoToken("0x45d4ec5c687A7fe1cE035353e0CBF086640f373E")
    //transferirTokens()
    console.log("Saldo Wallet PAto")
    await obtenerSaldo("0x45d4ec5c687A7fe1cE035353e0CBF086640f373E")
    console.log("Saldo Wallet Fabian")
    await obtenerSaldo("djfas.eth")
}

const obtenerSaldoToken = async(wallet) => {
     var balance = await tokenContract.balanceOf(wallet)
     console.log(balance)
     var nombre = await tokenContract.name()
     console.log(nombre)
 }

const transferirTokens = async() =>{
     //cambio de provider, para que sea la wallet quien pague el ether de la operacion
     const tokenWithSigner = tokenContract.connect(wallet);
     tx = tokenWithSigner.transfer("0xE8AD4CeE8aF64eeB16DE58Fc40A9fb2376091BCe", 2);
 }

transferirTokens()
