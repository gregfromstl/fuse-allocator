// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

import "./FusePoolDirectory.sol";
import "./CTokenInterfaces.sol";

contract FuseAllocator is Ownable {
  FusePoolDirectory public directory;

  /**
   * @notice Set the FusePoolDirectory to be used.
   * @param _directory address The address of the directory contract.
   */
  function setDirectory(address _directory) external onlyOwner {
    directory = FusePoolDirectory(_directory);
  }

  /**
   * @notice Deposit the all tokens in exchange for the corresponding fTokens
   * @dev The amount of fTokens received is the number of tokens divided by the exchange rate (https://docs.rari.capital/fuse/#exchange-rate)
   */
  function deposit(address tokenAddress, address fTokenAddress)
    external
    onlyOwner
  {
    ERC20 token = ERC20(tokenAddress);
    token.approve(fTokenAddress, amount); // approve the fToken address to transfer 'amount' in tokenAddress

    CErc20Interface fToken = CErc20Interface(fTokenAddress);
    fToken.mint(amount);
  }

  // function enterMarkets(string[]) external onlyOwner {
  //   return;
  // }

  // function exitMarket(string) external onlyOwner {
  //   return;
  // }

  // function withdrawAmount(string, uint256) external onlyOwner {
  //   return;
  // }

  // function withdrawAll(string) external onlyOwner {
  //   return;
  // }
}
