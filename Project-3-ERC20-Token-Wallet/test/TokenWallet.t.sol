// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {MyToken} from "../src/myToken.sol";
import {TokenWallet} from "../src/TokenWallet.sol";

contract TokenWalletTest is Test {
    MyToken public token;
    TokenWallet public wallet;

    address public alice = makeAddr("alice");
    address public bob = makeAddr("bob");

    function setUp() public {
        token = new MyToken();
        wallet = new TokenWallet(address(token));

        // Give Alice 500 MTK
        token.transfer(alice, 500 * 10 ** 18);
    }

    function testGetBalance() public view {
        uint256 balance = wallet.getBalance(alice);

        assertEq(balance, 500 * 10 ** 18);
    }

    function testTransferTokens() public {
        uint256 amount = 100 * 10 ** 18;

        // Alice gives permission to the wallet
        vm.prank(alice);
        token.approve(address(wallet), amount);

        // Alice asks wallet to transfer tokens to Bob
        vm.prank(alice);
        wallet.transferTokens(bob, amount);

        assertEq(token.balanceOf(alice), 400 * 10 ** 18);
        assertEq(token.balanceOf(bob), 100 * 10 ** 18);
    }

    function testCannotTransferMoreThanBalance() public {
        uint256 amount = 600 * 10 ** 18;

        vm.prank(alice);
        token.approve(address(wallet), amount);

        vm.prank(alice);
        vm.expectRevert(TokenWallet.InsufficientBalance.selector);

        wallet.transferTokens(bob, amount);
    }

    function testCannotTransferZeroAmount() public {
        vm.prank(alice);
        vm.expectRevert(TokenWallet.InvalidAmount.selector);

        wallet.transferTokens(bob, 0);
    }

    function testCannotTransferToZeroAddress() public {
        vm.prank(alice);
        vm.expectRevert(TokenWallet.InvalidAddress.selector);

        wallet.transferTokens(address(0), 100 * 10 ** 18);
    }

    function testCannotGetZeroAddressBalance() public {
        vm.expectRevert(TokenWallet.InvalidAddress.selector);

        wallet.getBalance(address(0));
    }
}