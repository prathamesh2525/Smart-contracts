// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";


contract MyToken is ERC721 {
    uint public price;
    address public nftOwner;
    constructor() ERC721("MyToken", "MTK") {}

    function safeMint(address to, uint256 tokenId) public {
        _safeMint(to, tokenId);
        nftOwner = msg.sender;
    }

    function onSale(uint _price) public returns(uint) {
        require(msg.sender == nftOwner,"You are not NFT Owner");
        price = _price;
        return price;
    }

    function purchase(uint _amount, address payable _creator) public payable {
        require(_amount == price,"Specified Amount not matched with price");
        address buyer = msg.sender;
        uint nftCreatorStake = _amount /10;
        _amount = _amount - (nftCreatorStake);
        (bool sent,) = nftOwner.call{value: _amount-nftCreatorStake}("");
        require(sent,"Failed to send ether");
        (bool sentCreator,) = _creator.call{value: nftCreatorStake}("");
        require(sentCreator,"Failed to send ether");
        nftOwner = buyer;
    }

}
