// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";

contract SoulboundToken is ERC721 {
    error SoulboundToken__Token_No_existing();

    uint public s_tokenId;
    mapping(uint => string) public s_tokenIdToURI;
    mapping(address => uint) public s_ownerTokenId;

    event MintedToken(address indexed owner, uint indexed id);
    event BurnedToken(uint indexed id);

    constructor() ERC721("SIMPLE", "SST") {
        s_tokenId = 0;
    }

    function mint(string memory _tokenURI) external {
        // Reading the current token id from storage
        uint id = s_tokenId;
        // mapping the id to the passed URI
        s_tokenIdToURI[id] = _tokenURI;
        // Minting the token as the user is the new owner.
        _safeMint(msg.sender, id);

        s_tokenId++;

        emit MintedToken(msg.sender, id);
    }

    function burn(uint tokenId) external {
        if (
            keccak256(abi.encodePacked(s_tokenIdToURI[tokenId])) ==
            keccak256(abi.encodePacked(""))
        ) {
            revert SoulboundToken__Token_No_existing();
        }
        _burn(tokenId);

        emit BurnedToken(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override
        returns (string memory)
    {
        return s_tokenIdToURI[tokenId];
    }

    function _transfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override {}
}
