// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "lib/forge-std/src/Script.sol";
import {SoulboundToken} from "../src/SoulboundToken.sol";

contract DeploySoulboundToken is Script {
    function run() external returns (SoulboundToken) {
        vm.startBroadcast();
        SoulboundToken token = new SoulboundToken();
        vm.stopBroadcast();

        return token;
    }
}
