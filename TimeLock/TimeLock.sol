// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract TimeLock{
     mapping(address => uint) public balances;
     mapping (address => uint) public lockTime;

     function deposit()public payable{
         balances[msg.sender] += msg.value;
         lockTime[msg.sender] +=block.timestamp + 25 seconds;
     }

     function withdraw() public payable{
         require(balances[msg.sender]>0,"Insufficient Funds");
         require(block.timestamp>lockTime[msg.sender],"Lock time has not till expired");
         uint amount = balances[msg.sender];
         balances[msg.sender] = 0;
         payable(msg.sender).transfer(amount);
     }
}
