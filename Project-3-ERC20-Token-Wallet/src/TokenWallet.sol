// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TokenWallet {
    IERC20 public token;

    error InvalidAddress();
    error InvalidAmount();
    error InsufficientBalance();

    constructor(address tokenAddress) {
        if (tokenAddress == address(0)) {
            revert InvalidAddress();
        }

        token = IERC20(tokenAddress);
    }

    // Check token balance of a user
    function getBalance(address user) public view returns (uint256) {
        if (user == address(0)) {
            revert InvalidAddress();
        }

        return token.balanceOf(user);
    }

    // Transfer tokens from the caller to another address
    function transferTokens(address recipient, uint256 amount) public {
        if (recipient == address(0)) {
            revert InvalidAddress();
        }

        if (amount == 0) {
            revert InvalidAmount();
        }

        uint256 senderBalance = token.balanceOf(msg.sender);

        if (senderBalance < amount) {
            revert InsufficientBalance();
        }

        bool success = token.transferFrom(
            msg.sender,
            recipient,
            amount
        );

        require(success, "Token transfer failed");
    }
}