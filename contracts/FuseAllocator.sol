// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.5.16;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

import "./interfaces/CTokenInterfaces.sol";
import "./interfaces/ComptrollerInterface.sol";

contract FuseAllocator is Ownable {
  ComptrollerInterface public comptroller;

  /**
   * @notice Sets the desired pool based on the comptroller address.
   * @param _comptroller address The address of the comptroller contract for the desired pool.
   */
  function setComptroller(address _comptroller) external onlyOwner {
    comptroller = Comptroller(_comptroller);
  }

  /**
   * @notice Deposit the all tokens in exchange for the corresponding fTokens, then enter the designated pool with those fTokens.
   * @dev The amount of fTokens received is the number of tokens divided by the exchange rate (https://docs.rari.capital/fuse/#exchange-rate)
   */
  function deposit(
    address tokenAddress,
    address fTokenAddress,
    uint256 amount
  ) external onlyOwner {
    ERC20 token = ERC20(tokenAddress);

    token.approve(fTokenAddress, amount); // approve the fToken address to transfer 'amount' in tokenAddress

    CErc20Interface fToken = CErc20Interface(fTokenAddress);
    require(fToken.mint(amount) == 0, "Failed to mint fTokens");

    require(
      comptroller.enterMarkets([fTokenAddress]) == [0],
      "Failed to enter pool"
    );
  }

  /**
   * @notice Redeem the specified fTokens and transfer redeemed tokens to the treasury / contract owner
   * @dev The amount of tokens received is based on the current exchange rate (https://docs.rari.capital/fuse/#exchange-rate)
   */
  function withdraw(address tokenAddress, address fTokenAddress)
    external
    onlyOwner
  {
    require(comptroller.exitMarket(fTokenAddress) == 0, "Failed to exit pool");

    CErc20Interface fToken = CErc20Interface(fTokenAddress);
    uint256 amount = fToken.balanceOf(address(this));
    require(fToken.redeem(amount) == 0, "Failed to redeem fTokens");

    ERC20 token = ERC20(tokenAddress);
    safeTransferFrom(
      token,
      address(this),
      owner(),
      token.balanceOf(address(this))
    ); // send all withdrawn tokens to treasury
  }
}
