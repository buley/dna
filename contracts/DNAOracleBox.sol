// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DNAOracleBox is ERC721Enumerable, ERC721URIStorage, Ownable {
    using SafeMath for uint256;

    uint256 private mintSequence = 1;
    uint256 public constant MAX_MINT = 6510;
    uint256 public lootBoxPrice = 0.01 ether;  // Example price

    // This is just a placeholder for the Oracle; in a real-world scenario, you'd have more specific implementations
    // for the Oracle, such as Chainlink's interfaces and logic for fetching random data.
    address public oracleAddress;

    modifier onlyOracle() {
        require(msg.sender == oracleAddress, "Not authorized");
        _;
    }

    constructor(address _oracleAddress) ERC721("DNAOracleBox", "DNALB") {
        oracleAddress = _oracleAddress;
    }

    function purchaseLootBox() public payable {
        require(mintSequence <= MAX_MINT, "All loot boxes have been minted");
        require(msg.value == lootBoxPrice, "Incorrect Ether sent");

        // Here, you would usually interact with the Oracle to assign the NFT attributes.
        // The Oracle can then call a function to finalize the minting with the attributes.

        // Placeholder for Oracle call
        requestOracleForAttributes();

        // This is just a basic sequence increment. In a real-world application, 
        // you'd wait for the Oracle to send back the NFT attributes before minting.
        _mint(msg.sender, mintSequence); 
        mintSequence++;
    }

    function requestOracleForAttributes() internal {
        // Here, you'd initiate the Oracle request. This is a placeholder.
    }

    // This function is a placeholder for when the Oracle sends back the attributes.
    // It's called by the Oracle to assign attributes to the NFT and finalize the minting.
    function finalizeMinting(address to, uint256 tokenId, string memory attributes) external onlyOracle {
        // Assign the attributes to the NFT. This is a simplified representation.
        _setTokenURI(tokenId, attributes);
        
        // Complete the minting process
        _mint(to, tokenId);
    }

    function setLootBoxPrice(uint256 newPrice) external onlyOwner {
        lootBoxPrice = newPrice;
    }

    function setOracleAddress(address newOracleAddress) external onlyOwner {
        oracleAddress = newOracleAddress;
    }

    function withdraw() external onlyOwner {
        uint256 balance = address(this).balance;
        payable(owner()).transfer(balance);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function supportsInterface(bytes4 interfaceId) public view override(ERC721Enumerable, ERC721URIStorage) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    function tokenURI(uint256 tokenId) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }

    function _beforeTokenTransfer(address from, address to, uint256 firstTokenId, uint256 batchSize) internal virtual override(ERC721, ERC721Enumerable) {
        ERC721Enumerable._beforeTokenTransfer(from, to, firstTokenId, batchSize);
    }


}
