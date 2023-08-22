// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract WonderlandWanderers is ERC721, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    // Mapping to store custom URIs for each token
    mapping(uint256 => string) private _tokenIdToMetadataURI;
    // Mapping to store and check if ImageUri exists figured this will be cheaper and faster than looping through each tokenId and comparing their URI.
    mapping(string => bool) private _imageUriExist;
    // Mapping to store id to coresponding ImageUri
    mapping(uint256 => string) private _tokenIdToImageUri;

    constructor() ERC721("Wonderland Wanderers", "WW") {}

    function safeMint(
        address to,
        string memory metaDataUri,
        string memory imageUri
    ) public {
        require(_imageUriExist[imageUri] == false, "Item Exists Already");
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _tokenIdToMetadataURI[tokenId] = metaDataUri; // Store the metaData URI for the token
        _imageUriExist[imageUri] = true; // store the image Uri from the metadata exist bool to use for checks
        _tokenIdToImageUri[tokenId] = imageUri; //store a mapping of token Id to image uri so as to enable some further actions
    }

    // Override tokenURI function to use custom URIs
    function tokenURI(
        uint256 tokenId
    ) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        require(
            _exists(tokenId),
            "ERC721Metadata: URI query for nonexistent token"
        );
        return _tokenIdToMetadataURI[tokenId];
    }

    function getTotalItemCount() public view returns (uint256) {
        uint256 count = _tokenIdCounter.current();
        return count;
    }

    function itemExists(string memory proposedURI) public view returns (bool) {
        return _imageUriExist[proposedURI];
    }

    // The following functions are overrides required by Solidity.

    function _burn(
        uint256 tokenId
    ) internal override(ERC721, ERC721URIStorage) {
        string memory imageUri = _tokenIdToImageUri[tokenId];
        delete _tokenIdToMetadataURI[tokenId];
        delete _imageUriExist[imageUri];
        delete _tokenIdToImageUri[tokenId];
        super._burn(tokenId);
    }

    function supportsInterface(
        bytes4 interfaceId
    ) public view override(ERC721, ERC721URIStorage) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}
