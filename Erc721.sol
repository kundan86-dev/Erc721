// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFTMarketplace is ERC721, Ownable {
    uint256 private tokenCount;
    uint256 public tokenPrice = 10 wei;
    mapping(uint256 => uint256) public balances;

    constructor() ERC721("Rupees", "Rs") {}

    function mintNFT() public payable {
        require(msg.value >= tokenPrice, "Insufficient funds");
        tokenCount++;
        uint256 newTokenId = tokenCount;
        _mint(msg.sender, newTokenId);
        balances[newTokenId] = msg.value;
    }

    function setTokenPrice(uint256 newPrice) public onlyOwner {
        tokenPrice = newPrice;
    }

    function burnNFT(uint256 tokenId) public onlyOwner {
        _burn(tokenId);
        balances[tokenId] = 0;
    }

    function withdrawBalance() public onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No balance to withdraw");
        payable(msg.sender).transfer(balance);
    }
}
