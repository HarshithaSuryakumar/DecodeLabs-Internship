// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {MyToken} from "../src/myToken.sol";

contract MyTokenTest is Test {
    MyToken public token;

    address public user = makeAddr("user");

    function setUp() public {
        token = new MyToken();
    }

    function testTokenName() public {
        assertEq(token.name(), "My Token");
    }

    function testTokenSymbol() public {
        assertEq(token.symbol(), "MTK");
    }

    function testTotalSupply() public {
        assertEq(token.totalSupply(), 1000 * 10 ** 18);
    }

    function testDeployerGetsAllTokens() public {
        assertEq(token.balanceOf(address(this)), 1000 * 10 ** 18);
    }

    function testTransfer() public {
        token.transfer(user, 100 * 10 ** 18);

        assertEq(token.balanceOf(user), 100 * 10 ** 18);
        assertEq(token.balanceOf(address(this)), 900 * 10 ** 18);
    }

    function testCannotTransferMoreThanBalance() public {
        vm.expectRevert();

        token.transfer(user, 1001 * 10 ** 18);
    }
}