<img src="https://github.com/user-attachments/assets/fe0310fb-4842-4986-b466-0d74f52b5f13"/>

# ERC721
The ERC721 project provides a comprehensive implementation of the ERC721 standard for non-fungible tokens (NFTs) on the Ethereum blockchain. This project is designed to facilitate the creation, management, and transfer of unique digital assets. With a strong focus on security and extensibility, it includes additional features like metadata and URI Storage extensions

## Table of Contents

- [Introduction](#erc721)
- [Notes](#notes)
  - [ERC721 Standard](#erc721-standard)
  - [ERC721 Extentions](#erc721-extentions)
- [Features and Functionality](#features-and-functionality)
- [Implementation](#implementation)
  - [Contract Overview](#contract-overview)
  - [Tests](#tests)
- [Running the Project Locally](#running-the-project-locally)
  
## Notes

### ERC721 Standard

The ERC721 standard defines a set of rules for creating non-fungible tokens (NFTs) on the Ethereum blockchain. Unlike fungible tokens (e.g., ERC20), each ERC721 token is unique, undividable and cannot be replaced by another token. This standard enables the representation of ownership of unique items such as digital art, collectibles, and other assets.

### ERC721 Extentions

Extensions for ERC standards are additional features or functionalities that build upon the base standards, like ERC721, to provide enhanced capabilities. For example, the metadata extension for ERC721 adds the ability to associate detailed information such as names, descriptions, and images with each token. These extensions allow developers to create more versatile and feature-rich applications, ensuring that the tokens not only comply with the core standards but also meet the specific needs of various use cases

## Features and Functionality

- **ERC721 Compliance**: Fully compliant with the ERC721 standard, ensuring compatibility with existing tools and platforms.
- **Minting and Burning**: Supports the creation (minting) and destruction (burning) of tokens, allowing for flexible asset management.
- **Metadata Extension**: Implements the metadata extension to provide additional information about each token.
- **Ownership Transfer**: Facilitates secure and transparent transfer of token ownership.
- **Safe Transfers**: Implements mechanisms to ensure that tokens are safely transferred to contracts that are aware of ERC721 tokens.

## Implementation

### Contract Overview

The ERC721 project is structured into several key contracts:

- **ERC165.sol**: Implements the ERC165 standard for interface detection.
- **ERC721.sol**: Core implementation of the ERC721 standard.
- **ERC721URIStorage.sol**: Extension of ERC721 to include token URIs for metadata.
- **IERC165.sol**: Interface for ERC165 standard.
- **IERC721.sol**: Interface for the ERC721 standard.
- **IERC721Metadata.sol**: Interface for the ERC721 metadata extension.
- **IERC721Receiver.sol**: Interface for contracts that want to support safe transfers.
- **MyContractReceiver.sol**: Example implementation of a contract that handles safe transfers.
- **MyToken.sol**: Implementation of a custom ERC721 token.
- **Strings.sol**: Utility library for string operations.

### Tests

The project includes a basic set of tests to ensure the functionality of the contracts. These tests cover:

- Basic ERC721 functionality (minting, burning, transferring).
- Metadata extension operations.

## Running the Project Locally

To run the ERC721 project locally, follow these steps:

1. **Clone the Repository**:
    ```bash
    git clone https://github.com/sssshefer/ERC721.git
    cd ERC721
    ```

2. **Install Dependencies**:
    ```bash
    npm install
    ```

3. **Compile Contracts**:
    ```bash
    npx hardhat compile
    ```

4. **Run Tests**:
    ```bash
    npx hardhat test
    ```
<a href="https://ru.freepik.com/free-vector/cvetnoi-fon-nft-s-muzskim-personazem-sidasim-za-noutbukom-i-sozdausim-novuu-tokenovuu-ploskuu-vektornuu-illustraciu_31643419.htm#fromView=search&page=1&position=0&uuid=ff4edd72-7d82-4f37-83e4-9ef37166a323">The pic is from macrovector on Freepik</a>
