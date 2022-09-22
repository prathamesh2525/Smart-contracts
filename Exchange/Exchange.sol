// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface IERC20 {
    function totalSupply() external view returns (uint);

    function balanceOf(address account) external view returns (uint);

    function transfer(address recipient, uint amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint amount) external returns (bool);

    function transferFrom( address sender, address recipient, uint amount ) external returns (bool);

}

interface IERC721 {
    event Transfer(address indexed from, address indexed to, uint indexed id);
    event Approval(address indexed owner, address indexed spender, uint indexed id);
    event ApprovalForAll( address indexed owner, address indexed operator, bool approved );
    function balanceOf(address owner) external view returns (uint balance);

    function ownerOf(uint tokenId) external view returns (address owner);

    function safeTransferFrom( address from, address to, uint tokenId ) external;

    function safeTransferFrom(address from, address to, uint tokenId, bytes calldata data ) external;

    function transferFrom(address from, address to, uint tokenId) external;

    function approve(address to, uint tokenId) external;

    function getApproved(uint tokenId) external view returns (address operator);

    function setApprovalForAll(address operator, bool _approved) external;

    function isApprovedForAll(address owner, address operator) external view returns (bool);
}

contract Exchange {
    IERC20 erc20 = IERC20(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4);
    IERC721 erc721 = IERC721(0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2);
    address erc721Owner = 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db;

    function buy(uint _tokenId) public returns(bool ){
        require(erc20.balanceOf(msg.sender)>=20,"Not Enough Token");
        erc721.safeTransferFrom((erc721Owner), msg.sender, _tokenId);
        erc20.transfer(erc721Owner, 20);
        return true;
    }

    function sell(uint _tokenId) public returns(bool ){
        require(erc721.ownerOf(_tokenId)==msg.sender,"You are not the owner");
        erc721.approve(address(this), _tokenId);
        erc721.transferFrom(msg.sender, 0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB, _tokenId);
        erc20.transferFrom(erc721Owner, msg.sender, 20);
        return true;
    }

    function get()public view returns(uint){
        return erc20.balanceOf(msg.sender);
    }
}
