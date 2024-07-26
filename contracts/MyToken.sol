// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC721.sol";
import "./ERC721URIStorage.sol";

contract MyToken is ERC721, ERC721URIStorage {
    address owner;

    constructor() ERC721("shefToken", "shef") {
        owner = msg.sender;
    }

    function safeMint(address to, uint tokenId) public {
        require(msg.sender == owner, "Not an owner");
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, tokenURI(tokenId));
    }

    function supportsInterface(
        bytes4 interfaceId
    ) public view override(ERC721) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://";
    }
    function _burn(uint tokenId) internal virtual override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }
}
