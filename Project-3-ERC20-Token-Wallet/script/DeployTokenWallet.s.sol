// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {MyToken} from "../src/myToken.sol";
import {TokenWallet} from "../src/TokenWallet.sol";

contract DeployTokenWallet is Script {
    function run() external returns (MyToken, TokenWallet) {
        vm.startBroadcast();

        MyToken token = new MyToken();
        TokenWallet wallet = new TokenWallet(address(token));

        vm.stopBroadcast();

        return (token, wallet);
    }
}