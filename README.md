# Smart-contracts
Following smart contracts are deployed on Ropsten Testnet.
They are verified and published on the same.

## Pharma.sol
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Pharma {
    bool public flag;
    uint public amountDeposited;
    address public logistic = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;
    address payable public owner;
    constructor() payable {
        owner = payable(msg.sender);
    }
    function deposit(uint amount) public payable{
        amountDeposited = amount;
    }

    function check(uint _temp, uint _humid) public {
        if(_temp > 10 && _temp< 20){
            if(_humid >25 && _humid< 35){
                flag = true;
            }
        }
    }

    function transfer() public {
        require(flag==true,"Temperature or Humidity is out of range, transaction cannot be completed!");
        (bool success,) = payable(logistic).call{value: amountDeposited}("");
        require(success,"Failed to send Ether");
        }

    fallback() external {}
}
```
### Contract Address: 0xF7D4FA52705BF07D183c25B0F8fE48883f875f72
![Screenshot (7)](https://user-images.githubusercontent.com/61145586/187062271-5a93228f-be50-4767-8450-6ab9c3e068f6.png)
![Screenshot (8)](https://user-images.githubusercontent.com/61145586/187062272-e885d8d9-3a44-43d5-8d1e-9e6c2046f566.png)
![Screenshot (9)](https://user-images.githubusercontent.com/61145586/187062276-7f8bf066-192a-40b6-a624-3f282d1b06f0.png)
![Screenshot (10)](https://user-images.githubusercontent.com/61145586/187062278-e4fc630e-179c-48a7-98f8-3bc54cacc174.png)
![Screenshot (11)](https://user-images.githubusercontent.com/61145586/187062279-d7f635fb-9a12-4f01-8e70-36772774edc6.png)


## Insurance.sol 
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Insurance {
    address payable public owner;
    constructor() payable {
        owner = payable(msg.sender);
    }
    address payable public user;

    function deposit(uint _amount) public payable{
        if(_amount == 4){
            user = payable(msg.sender);
        }
    }
    bool public flag;

    function isLate(bool _val) public {
        require(msg.sender ==user,"Only user can call this function");
        flag = _val;
        if(flag == true){
            (bool success,) = owner.call{value: 10500 }("");
            require(success,"Failed to send Ether");
        }
    }

}
```
### Contract Address: 0xAF84F18fe1223d3d82bc728A5908F73A747CB7f7
![Screenshot (13)](https://user-images.githubusercontent.com/61145586/187062292-1e3bdf64-373a-4cc5-b44a-0dfb4c29bab7.png)
![Screenshot (14)](https://user-images.githubusercontent.com/61145586/187062293-8a8e0a81-5998-4ae8-9fe3-642e2420040c.png)
![Screenshot (15)](https://user-images.githubusercontent.com/61145586/187062295-1cc72cb6-0c37-4ec7-8763-05814555da80.png)
![Screenshot (16)](https://user-images.githubusercontent.com/61145586/187062296-5bd5c630-e30e-468d-a811-9dc9cebcb578.png)
![Screenshot (17)](https://user-images.githubusercontent.com/61145586/187062297-7b4ca184-20f6-4ac4-83dc-65bba9000bae.png)
![Screenshot (18)](https://user-images.githubusercontent.com/61145586/187062299-9f859335-fe24-4100-9f38-938b721bcc8a.png)
