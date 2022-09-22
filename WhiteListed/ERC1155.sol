// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;
 
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
 
contract MyToken is ERC1155 {
 
    uint constant public nftPrice = 0.2 ether;
    mapping (address => bool) public isWhitelisted;
    address public owner = msg.sender;
     
    modifier onlyOwner(){
        require(msg.sender == owner, "You are not the Owner");
        _;
    }
    constructor() ERC1155(" ") {
        isWhitelisted[owner] = true;
    }
 
    function mintBatch(uint256[] memory ids, uint256[] memory amounts, bytes memory data)
        public
        payable 
    {   
        uint totalPrice = getPrice(amounts);
        require(isWhitelisted[msg.sender], "You are not whitelisted!");
        require(totalPrice <= 1 ether, "You can mint atmost 5 nfts");
        require(msg.value >= totalPrice, "you are not sending enough ethers!"); 
        payable(owner).transfer(msg.value);
        _mintBatch(msg.sender, ids, amounts, data);
    }
 
    function makeAddressWhiteListed(address _account) public onlyOwner{
        require(!isWhitelisted[_account], "the address is already whitelisted");
        
        isWhitelisted[_account] = true;
    }
 
    function getPrice(uint[] memory arr) private pure returns(uint){
         uint sum = 0;
         for(uint i = 0; i < arr.length; i++){
              sum += arr[i];
         }
         return sum * nftPrice;   
 }
}
