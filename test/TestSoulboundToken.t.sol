// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "lib/forge-std/src/Test.sol";
import {DeploySoulboundToken} from "../script/DeploySoulboundToken.s.sol";
import {SoulboundToken} from "../src/SoulboundToken.sol";

contract TestSoulboundToken is Test {
    SoulboundToken token;
    string tokenURI =
        "ipfs://Qmbmj8mvUeyZPsSQ6uLgt6s6J7M8FWLV21SKVxagveiTbX?filename=magicBit.jpg";
    address USER = makeAddr("user");
    address RECEIVER = makeAddr("receiver");

    function setUp() external {
        DeploySoulboundToken deployer = new DeploySoulboundToken();
        token = deployer.run();
    }

    function testName() external view {
        string memory name = "SIMPLE";
        assert(
            keccak256(abi.encodePacked(token.name())) ==
                keccak256(abi.encodePacked(name))
        );
    }

    modifier testSetUp() {
        vm.prank(USER);
        token.mint(tokenURI);
        _;
    }

    // This test should not be passed since the transfer function
    // is not defined and therefore the token cannot be transfered.
    function testTransfer() external testSetUp {
        uint tokenId = token.s_ownerTokenId(USER);

        vm.prank(USER);
        token.approve(RECEIVER, tokenId);

        vm.prank(RECEIVER);
        token.transferFrom(USER, RECEIVER, tokenId);
        assert(token.balanceOf(RECEIVER) == 0);
    }
}
