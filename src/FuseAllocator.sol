// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

import "./FusePoolDirectory.sol";

contract FuseAllocator is Ownable {
  FusePoolDirectory public directory;

  function setDirectory(address _directory) external onlyOwner {
    directory = FusePoolDirectory(_directory);
  }

  // function depositStables(string, uint256) external onlyOwner {
  //   return;
  // }

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
