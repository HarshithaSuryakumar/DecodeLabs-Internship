// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {ERC721URIStorage} from
    "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract MyNFT is ERC721URIStorage {
    uint256 private s_tokenCounter;

    constructor() ERC721("HarshyNFT", "HNFT") {
        s_tokenCounter = 0;
    }

    function mintNFT(string memory tokenURI)
        public
        returns (uint256)
    {
        uint256 tokenId = s_tokenCounter;

        _safeMint(msg.sender, tokenId);
        _setTokenURI(tokenId, tokenURI);

        s_tokenCounter++;

        return tokenId;
    }

    function getTokenCounter() public view returns (uint256) {
        return s_tokenCounter;
    }
}