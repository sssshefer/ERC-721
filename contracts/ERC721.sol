// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IERC721Metadata.sol";
import "./IERC721Receiver.sol";
import "./ERC165.sol";
import "./Strings.sol";
import "./IERC721.sol";

contract ERC721 is ERC165, IERC721, IERC721Metadata {
    using Strings for uint;

    string public name;
    string public symbol;

    mapping(address => uint) _balances;
    mapping(uint => address) _owners;
    mapping(uint => address) _tokenApprovals;
    mapping(address => mapping(address => bool)) _operatorApprovals;

    modifier _requireMinted(uint tokenId) {
        require(_exists(tokenId), "Not minted");
        _;
    }

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
    }

    function balanceOf(address owner) public view returns (uint) {
        require(owner != address(0), "Zero address is not allowed");
        return _balances[owner];
    }

    function _exists(uint tokenId) internal view returns (bool) {
        return _owners[tokenId] != address(0);
    }

    function transferFrom(address from, address to, uint tokenId) external {
        require(
            _isApprovedOrOwner(msg.sender, tokenId),
            "You are not an owner or approved"
        );
        _transfer(from, to, tokenId);
    }

    function safeTransferFrom(
        address from,
        address to,
        uint tokenId,
        bytes calldata data
    ) external {
        require(
            _isApprovedOrOwner(msg.sender, tokenId),
            "You are not an owner or approved"
        );
        _safeTransfer(from, to, tokenId, data);
    }


    function _baseURI() internal pure virtual returns (string memory) {
        return "";
    }

    function tokenURI(
        uint tokenId
    ) public view _requireMinted(tokenId) returns (string memory) {
        string memory baseURI;
        return
            bytes(baseURI).length > 0
                ? string(abi.encodePacked(baseURI, tokenId.toString()))
                : "";
    }

    function approve(address to, uint tokenId) public {
        address _owner = ownerOf(tokenId);
        require(
            _owner == msg.sender || isApprovedForAll(_owner, msg.sender),
            "not an owner"
        );
        require(to != _owner, "Cannot approve to yourself");
        _tokenApprovals[tokenId] = to;
        emit Approval(_owner, to, tokenId);
    }
    
    function setApprovalForAll(
        address operator,
        bool approved
    ) external{

    }

    function ownerOf(
        uint tokenId
    ) public view _requireMinted(tokenId) returns (address) {
        return _owners[tokenId];
    }

    function supportsInterface(
        bytes4 interfaceId
    ) public view virtual override returns (bool) {
        return
            interfaceId == type(IERC721).interfaceId ||
            super.supportsInterface(interfaceId);
    }

    function isApprovedForAll(
        address owner,
        address operator
    ) public view returns (bool) {
        return _operatorApprovals[owner][operator];
    }

    function getApproved(
        uint tokenId
    ) public view _requireMinted(tokenId) returns (address) {
        return _tokenApprovals[tokenId];
    }

    function burn(uint tokenId) public virtual {
        require(_isApprovedOrOwner(msg.sender, tokenId), "Not an owner");
        address owner = ownerOf(tokenId);
        delete _tokenApprovals[tokenId];
        _balances[owner]--;
        delete _owners[tokenId];
    }

    function _safeMint(address to, uint tokenId) internal virtual {
        _mint(to, tokenId);
        require(
            _checkOnERC721Received(msg.sender, to, tokenId),
            "Non ERC721 receiver"
        );
    }

    function _mint(address to, uint tokenId) internal virtual {
        require(to != address(0), "to cannot be zero");
        require(!_exists(tokenId), "Already exists");

        _owners[tokenId] = to;
        _balances[to]++;
    }

    function _safeTransfer(address from, address to, uint tokenId, bytes memory data) internal {
        _transfer(from, to, tokenId);

        require(
            _checkOnERC721Received(from, to, tokenId, data),
            "Non ERC721 receiver!"
        );
    }

    function _checkOnERC721Received(
        address from,
        address to,
        uint tokenId
    ) private returns (bool) {
        if (to.code.length > 0) {
            try
                IERC721Receiver(to).onERC721Received(
                    msg.sender,
                    from,
                    tokenId,
                    bytes(" ")
                )
            returns (bytes4 ret) {
                return ret == IERC721Receiver.onERC721Received.selector;
            } catch (bytes memory reason) {
                if (reason.length == 0) {
                    //there is no ERC721 interface implementation
                    revert("Non ERC721 receiver!");
                } else {
                    assembly {
                        revert(add(32, reason), mload(reason))
                    }
                }
            }
        } else {
            return true;
        }
    }

    function _transfer(address from, address to, uint tokenId) internal {
        require(ownerOf(tokenId) == from, "Not an owner!");
        require(to != address(0), "'to' Cannot be zero");

        _beforeTokenTransfer(from, to, tokenId);

        _balances[from]--;
        _balances[to]++;
        _owners[tokenId] = to;

        emit Transfer(from, to, tokenId);

        _afterTokenTransfer(from, to, tokenId);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint tokenId
    ) internal virtual {}

    function _afterTokenTransfer(
        address from,
        address to,
        uint tokenId
    ) internal virtual {}

    function _isApprovedOrOwner(
        address spender,
        uint tokenId
    ) internal view returns (bool) {
        address owner = ownerOf(tokenId);

        require(
            spender == owner ||
                isApprovedForAll(owner, spender) ||
                getApproved(tokenId) == spender,
            "Not an owner or approved!"
        );
        return true;
    }
}
