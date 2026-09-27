# Project 4 - NFT with Metadata

## Overview

This project implements an ERC-721 Non-Fungible Token (NFT)
using Solidity and Foundry.

The NFT supports minting, ownership tracking and off-chain
metadata stored using IPFS.

## Features

- ERC-721 NFT standard
- NFT minting using `_safeMint`
- Unique token IDs
- NFT ownership using `ownerOf`
- Token metadata using `tokenURI`
- Metadata and image stored on IPFS
- Smart contract testing using Foundry

## Technologies Used

- Solidity
- Foundry
- OpenZeppelin
- IPFS
- Pinata
- Anvil

## Project Structure

Project-4-NFT-With-Metadata/
- src/MyNFT.sol
- test/MyNFT.t.sol
- script/DeployMyNFT.s.sol
- metadata/1.json
- images/harshy-nft.png

## NFT Metadata

NFT Name: Harshy NFT #1

Standard: ERC-721

Metadata URI:

ipfs://bafkreihakguzttg4ezrzkrtdgiffr6x7zifb2sng77zczxm2xusyfabsim

## Testing

Run:

forge test

## Local Deployment

The contract was deployed and tested locally using Anvil.

The NFT was successfully minted and ownership was verified
using `ownerOf()`.

## Author

Harshitha Suryakumar