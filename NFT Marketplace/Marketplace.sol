// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";


contract marketPlace { 

    enum State{created,release}
    struct Item{
        State state;
        address seller;
        address token;
        uint price;
        uint tokenId;
    }
    uint public itemId = 0;
    mapping(uint=>Item)public items;
    uint public listingFee = 1 ether;
    function listNFT(address _token,uint _tokenId,uint _price)public{
        IERC721(_token).transferFrom(msg.sender,address(this),_tokenId);
        Item memory item = Item(State.created,msg.sender,_token,_price,_tokenId);
        itemId++;
        items[_tokenId] = item;
    }

    function balance(address check)public view returns(uint){
         return(check.balance);
     }

    function buy(uint _itemId)public payable{
        Item storage item = items[_itemId];
        require(msg.sender !=item.seller,"Seller cannot be buyer");
        require(item.state == State.created,"Item is not yet created");
        IERC721(item.token).transferFrom(address(this),msg.sender,item.tokenId);
        payable(item.seller).transfer(item.price);
    }

    function sell(uint _itemId) public {
        Item storage item = items[_itemId];
        require(msg.sender == item.seller,"Seller can only release the Item");
        require(item.state == State.created,"Items is not created");
        item.state = State.release;
        IERC721(item.token).transferFrom(address(this),msg.sender,item.tokenId);
    }
}
