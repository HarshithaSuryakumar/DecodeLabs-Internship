// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {MyNFT} from "../src/MyNFT.sol";

contract MyNFTTest is Test {
    MyNFT public nft;

    address public user = address(1);

    function setUp() public {
        nft = new MyNFT();
    }

    function testNameAndSymbol() public view {
        assertEq(nft.name(), "HarshyNFT");
        assertEq(nft.symbol(), "HNFT");
    }

    function testMintNFT() public {
        string memory metadataURI = "ipfs://QmExampleHash/1.json";

        vm.prank(user);
        uint256 tokenId = nft.mintNFT(metadataURI);

        assertEq(tokenId, 0);
        assertEq(nft.ownerOf(0), user);
        assertEq(nft.tokenURI(0), metadataURI);
        assertEq(nft.getTokenCounter(), 1);
    }

    function testMultipleNFTs() public {
        vm.startPrank(user);

        nft.mintNFT("ipfs://metadata/1.json");
        nft.mintNFT("ipfs://metadata/2.json");

        vm.stopPrank();

        assertEq(nft.ownerOf(0), user);
        assertEq(nft.ownerOf(1), user);
        assertEq(nft.getTokenCounter(), 2);
    }
}