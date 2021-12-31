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

  function depositAll(address tokenAddress) external onlyOwner {
    fTokenAddress = getfTokenAddress(tokenSymbol); // TODO: IMPLEMENT getfTokenAddress

    ERC20 token = ERC20(tokenAddress);
    token.approve(fTokenAddress, token.balanceOf(msg.sender));

    CErc20Interface fToken = CErc20Interface(fTokenAddress);
    fToken.mint(token.balanceOf(msg.sender));
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
