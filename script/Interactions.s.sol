// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "lib/forge-std/src/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {SoulboundToken} from "../src/SoulboundToken.sol";

contract MintSoulBoundNFT is Script {
    string private constant SOULBOUND =
        "ipfs://Qmbmj8mvUeyZPsSQ6uLgt6s6J7M8FWLV21SKVxagveiTbX?filename=magicBit.jpg";

    function run() external {
        address recentDeployment = DevOpsTools.get_most_recent_deployment(
            "SoulboundToken",
            block.chainid
        );
        mintTokenOnContract(recentDeployment);
    }

    function mintTokenOnContract(address _contract) public {
        vm.startBroadcast();
        SoulboundToken(_contract).mint(SOULBOUND);
        vm.stopBroadcast();
    }
}
