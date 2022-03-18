// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./Base64.sol";

contract ERC721Token is ERC721 {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    struct MetaData {
        string name;
        string description;
        string image;
    }

    mapping(uint256 => MetaData) public metadataMap;

    constructor() ERC721("ERC721Token", "ECT") {}

    function mint(
        string memory _name,
        string memory _description,
        string memory _image
    ) external {
        uint256 tokenId = _tokenIdCounter.current();
        metadataMap[tokenId] = MetaData(_name, _description, _image);

        _tokenIdCounter.increment();
        _safeMint(msg.sender, tokenId);
    }

    function tokenURI(uint256 _tokenId)
        public
        view
        override
        returns (string memory)
    {
        MetaData memory metadata = metadataMap[_tokenId];

        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "',
                        metadata.name,
                        '", "description":"',
                        metadata.description,
                        '", "image":"',
                        metadata.image,
                        '"}'
                    )
                )
            )
        );
        return string(abi.encodePacked("data:application/json;base64,", json));
    }
}
