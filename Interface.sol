// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface ISwitch {
function switchOn() external returns(uint);
function switchOff() external returns(uint);
  }

//create Bulb contract here
contract Bulb is ISwitch {
    function switchOn() public pure override returns(uint){
        return 1;
    }
    function switchOff() public pure override returns(uint){
        return 0;
    }
}
