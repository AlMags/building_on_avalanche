// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, ERC20Burnable, Ownable {

    constructor() ERC20("Degen", "DGN") {}

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function decimals() override public pure returns (uint8){
        return 0;
    }

    function getBalance() external view returns (uint256) {
        return balanceOf(msg.sender);
    }

    function transferTokens(address receiver, uint256 amount) external {
        require(amount > 0, "Amount must be greater than zero");
        require(balanceOf(msg.sender) >= amount, "Insufficient Degen Tokens");
        _transfer(msg.sender, receiver, amount);
    }

    function burnTokens(uint256 amount) external {
        require(amount > 0, "Amount must be greater than zero");
        _burn(msg.sender, amount);
    }

    function burnFrom(address account, uint256 amount) override public {
        require(amount > 0, "Amount must be greater than zero");
        _burn(account, amount);
    }

    function redeemTokens(address seller, uint256 choice) external {
        uint256 amount = 0;
        require(choice > 0, "Amount must be greater than zero");
        require(choice <= 3 && choice >=0, "Choices are only between 1 - 3");
        if(choice == 1){
            amount = 100;
        }else if (choice == 2){
            amount = 75;
        }else if (choice == 3){
            amount = 50;
        }
        _transfer(msg.sender, seller, amount);
    }

    function displayNFTItems() external pure returns (string memory, string memory, string memory) {
        return ("Meta NFT - 100\n", "Meta Shirt 2 - 75\n", "Mystery Meta Item 3 - 50\n");
    }
}
