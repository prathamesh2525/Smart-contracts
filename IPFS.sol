// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
contract artworks is ERC1155 {
    uint256 public constant art1 = 1;
    uint256 public constant art2 = 2;
    uint256 public constant art3 = 3;
    constructor() ERC1155("https://ipfs.io/ipfs/bafybeiefntwgfjbszhbqxymbv2qivo6q2xjf2mq4zi6gtrv43pjftzmsb4/{id}.json") {
        _mint(msg.sender, art1, 1, "");
        _mint(msg.sender, art2, 1, "");
        _mint(msg.sender, art3, 1, "");
    }
      function uri(uint256 _tokenid) override public pure returns (string memory) {
        return string(
            abi.encodePacked(
                "https://ipfs.io/ipfs/bafybeiefntwgfjbszhbqxymbv2qivo6q2xjf2mq4zi6gtrv43pjftzmsb4/",
                Strings.toString(_tokenid),".json"
            )
        );
      }
}
