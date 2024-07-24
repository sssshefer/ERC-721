// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IERC721Metadata.sol";

contract ERC721 is IERC721Metadata{
    string public name;
    string public symbol;

    constructor (string memory _name, string memory _symbol){
        name = _name;
        symbol = _symbol;
    }
}
