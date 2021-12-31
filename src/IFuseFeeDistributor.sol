pragma solidity ^0.8.0;

interface IFuseFeeDistributor {
  function minBorrowEth() external view returns (uint256);

  function maxSupplyEth() external view returns (uint256);

  function maxUtilizationRate() external view returns (uint256);

  function interestFeeRate() external view returns (uint256);

  function() external payable;
}
