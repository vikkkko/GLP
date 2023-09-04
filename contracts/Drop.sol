// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";

contract Drop is Ownable, IERC721Receiver{

    mapping(address => uint) m;

    address[] receivers;
    uint[] ids;

    IERC721 nft;

    constructor(IERC721 _nft) Ownable(){
        nft = _nft;
    }

    function query(uint index) external view returns (address, uint){
        return (receivers[index], ids[index]);
    }


    function register(address[] memory _receivers, uint[] memory _ids) external onlyOwner {
        require(_receivers.length == _ids.length, "length");
        ids = _ids;
        receivers = _receivers;
    }

    function send() external onlyOwner{
        for(uint i = 0; i < receivers.length; i++){
            nft.transferFrom(address(this), receivers[i], ids[i]);
        }
        delete receivers;
    }

    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external pure returns (bytes4){
        return  IERC721Receiver.onERC721Received.selector;
    }
}