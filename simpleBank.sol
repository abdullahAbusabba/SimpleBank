// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

contract SimpleBank {

struct User {

    string name;
    uint balance;
    uint userId;
    uint userTransaction;
}


 address public owner;
 mapping (address => User) public userAddresses;
 mapping (address => bool) public isRegisterd;

 
 constructor() {
     owner = msg.sender;
 }

 function createUser(string memory name,uint balance) public {
     userAddresses[msg.sender].name = name;
     userAddresses[msg.sender].balance = balance;
    userAddresses[msg.sender].userId +=1;
     isRegisterd[msg.sender] = true;
 
 }

  modifier onlyOwner {
        require(msg.sender == owner,"not owner");
        _;
    }

  modifier isRegister {
        require(isRegisterd[msg.sender] == true,"not register");
        _;
        
    }

 function deposit(uint amount) public payable isRegister{
     userAddresses[msg.sender].balance += amount;
     userAddresses[msg.sender].userTransaction += 1;
 }

  function withdraw(uint amount) public isRegister  {
     userAddresses[msg.sender].balance -= amount;
     userAddresses[msg.sender].userTransaction += 1;
 }

 function getBalance() public  view returns(uint) {
     return userAddresses[msg.sender].balance;
 }

  function getTransaction() public  view returns(uint) {
     return userAddresses[msg.sender].userTransaction;
 }

 
 function getUser() public isRegister view returns(User memory) {
     return userAddresses[msg.sender];
 }


function deletUser() public isRegister () {
    delete userAddresses[msg.sender];
 }

function updetUser(string memory name ) public isRegister () {
     userAddresses[msg.sender].name = name;
 }

    }