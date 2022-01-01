// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./Base64.sol";

contract NFTs is ERC721, ERC721Enumerable {
    using Counters for Counters.Counter;

    Counters.Counter private NFTId;
    uint256 public maxSupply;

    constructor(uint256 _maxSupply) ERC721("ZhongGeoZ", "ZNG") {
        maxSupply = _maxSupply;
    }

    // Allows an user to mint a NFT
    function mint() public {
        uint256 current = NFTId.current();

        require(
            current < maxSupply,
            "There is not more ZhongGeoZ available... :("
        );

        _safeMint(msg.sender, current);

        NFTId.increment();
    }

    // Returns the metadata of the NFT
    function tokenURI(uint256 _NFTId)
        public
        view
        override
        returns (string memory)
    {
        require(
            _exists(_NFTId),
            "ERC721 Metadata: URI query for nonexistent token"
        );

        string memory jsonURI = Base64.encode(
            abi.encodePacked(
                '{ "name": "PlatziPunks #',
                _NFTId,
                '", "description": "Platzi Punks are randomized Avataaars stored on chain to teach DApp development on Platzi", "image": "',
                "// TODO: Calculate image URL",
                '"}'
            )
        );

        return
            string(abi.encodePacked("data:application/json;base64,", jsonURI));
    }

    // Override
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    // Override
    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
