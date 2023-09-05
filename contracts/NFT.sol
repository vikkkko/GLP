// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721EnumerableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721URIStorageUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721RoyaltyUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/CountersUpgradeable.sol";

contract NFT is 
    ERC721EnumerableUpgradeable, 
    ERC721URIStorageUpgradeable,
    ERC721RoyaltyUpgradeable,
    OwnableUpgradeable
{

    string baseURI_;

    using CountersUpgradeable for CountersUpgradeable.Counter;

    CountersUpgradeable.Counter index;

    function initialize(string memory uri) initializer external{
        __ERC721_init("Genesis LinkPass", "GLP");
        baseURI_ = uri;
        __Ownable_init();
    }

    function setBaseURI(string memory uri) external onlyOwner {
        baseURI_ = uri;
    }

    function mint(uint amount, address receiver) external onlyOwner {
        for(uint i = 1; i <= amount; i++){
            _safeMint(receiver, index.current());
            _setTokenURI(index.current(), baseURI_);
            index.increment();
        }
    }

    function mint(uint amount, address receiver, string memory uri) external onlyOwner {
        for(uint i = 1; i <= amount; i++){
            _safeMint(receiver, index.current());
            _setTokenURI(index.current(), uri);
            index.increment();
        }
    }

    function _baseURI() internal view override returns (string memory) {
        return baseURI_;
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 firstTokenId,
        uint256 batchSize
    ) internal virtual override(ERC721Upgradeable, ERC721EnumerableUpgradeable) {
        super._beforeTokenTransfer(from, to, firstTokenId, batchSize);
    }

    function _burn(uint256 tokenId) internal virtual override(ERC721Upgradeable, ERC721URIStorageUpgradeable, ERC721RoyaltyUpgradeable) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId) public view override(ERC721Upgradeable, ERC721URIStorageUpgradeable) returns (string memory) {
       return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
		public
		view
		override(
            ERC721EnumerableUpgradeable,
			ERC721URIStorageUpgradeable,
			ERC721RoyaltyUpgradeable
		)
		returns (bool)
	{
		return super.supportsInterface(interfaceId);
	}
}