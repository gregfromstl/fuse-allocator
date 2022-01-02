// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/util/SafeERC20.sol";

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

  /**
   * @notice Redeem the specified fTokens and transfer redeemed tokens to the treasury / contract owner
   * @dev The amount of tokens received is based on the current exchange rate (https://docs.rari.capital/fuse/#exchange-rate)
   */
  function withdraw(address tokenAddress, address fTokenAddress)
    external
    onlyOwner
  {
    CErc20Interface fToken = CErc20Interface(fTokenAddress);
    fToken.redeem(fToken.balanceOf(address(this)));

    ERC20 token = ERC20(tokenAddress);
    safeTransferFrom(
      token,
      address(this),
      owner(),
      token.balanceOf(address(this))
    ); // send all withdrawn tokens to treasury
  }

  /**
   * @notice Returns the names of available pools to enter
   */
  function getAvailablePools() external view returns (string[] availablePools) {
    (indexes, pools) = directory.getPublicPools();
    string[] memory availablePools = new string[](pools.length);
    for (uint256 i = 0; i < pools.length; i += 1) {
      (name, , , , ) = pools[i];
      availablePools[i] = name;
    }
  }

  function getComptroller(string poolName) internal view returns (Comptroller) {
    (indexes, pools) = directory.getPublicPools();
    string[] memory availablePools = new string[](pools.length);
    for (uint256 i = 0; i < pools.length; i += 1) {
      (name, , comptroller, , ) = pools[i];
      if (name == poolName) {
        return comptroller;
      }
    }
    // THROW ERROR
  }

  function enterPool(string pool, string[] fTokens) external onlyOwner {
    Comptroller comptroller = getComptroller(pool);
    comptroller.enterMarkets(fTokens);
  }

  function exitPool(string pool, string fToken) external onlyOwner {
    Comptroller comptroller = getComptroller(pool);
    comptroller.exitMarket(fToken);
  }
}
