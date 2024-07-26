//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
 
import "./ERC721.sol";

abstract contract ERC721URIStorage is ERC721 {
    mapping(uint => string) private _tokenURIs;

    function _setTokenURI(uint tokenId, string memory _tokenURI) internal virtual _requireMinted(tokenId) {
        _tokenURIs[tokenId] = _tokenURI;
    }

    function _burn(uint tokenId) internal virtual override {
        super._burn(tokenId);

        if(bytes(_tokenURIs[tokenId]).length != 0) {
            delete _tokenURIs[tokenId];
        }
    }
}
