// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./utils/FuseAllocatorTest.sol";

import "../FusePoolDirectory.sol";

// import {Errors} from "../FuseAllocator.sol";

contract SetDirectory is FuseAllocatorTest {
  function testOwnerCanSetDirectory(address directory) public {
    alice.setDirectory(directory);
    assertEq(address(alice.getDirectory()), directory);
  }

  function testNonOwnerCannotSetDirectory(address directory) public {
    try bob.setDirectory(directory) {
      fail();
    } catch Error(string memory error) {
      assertEq(error, "Ownable: caller is not the owner");
    }
  }
}

contract Deposit is FuseAllocatorTest {
  function testCanDepositTokens(uint256 amount) {
    // give allocator amount of tokens
    // given deposit is called by alice
    // assertEq(fToken.balanceOf(address(allocator)), amount / getExchangeRate)
    // assertEq(token.balanceOf(address(allocator)), 0)
  }

  function testAliceLosesNoTokensOnDeposit(uint256 amount) {
    // give alice amount of tokens
    // give allocator amount of tokens
    // given deposit is called by alice
    // assertEq(fToken.balanceOf(address(alice)), 0)
    // assertEq(token.balanceOf(address(alice)), amount)
  }

  function testCannotDepositTokensGivenNoTokens() {
    // given deposit is called by alice
    // given deposit is tried by alice
    // expect no tokens error
  }

  function testCanDepositMoreTokensLater(
    uint256 initialAmount,
    uint256 laterAmount
  ) {
    // give allocator initialAmount of tokens
    // given deposit is called by alice
    // assertEq(fToken.balanceOf(address(allocator)), initialAmount / getExchangeRate)
    // give allocator laterAmount of tokens
    // given deposit is called by alice
    // assertEq(fToken.balanceOf(address(allocator)), (initialAmount + laterAmount) / getExchangeRate) // assumes the exchange rate does not change between -- need to check
  }

  function testNonOwnerCannotDepositTokens(uint256 amount) {
    // give bob amount of tokens
    // give allocator amount of tokens
    // try deposit is called by bob
    // expect not owner failure
  }
}

contract Withdraw is FuseAllocatorTest {
  function testCanWithdraw(uint amount) {
    // give allocator amount of fTokens
    // withdraw
    // assertEq(fToken.balanceOf(address(alice)), amount * getExchangeRate)
  }

  function testNonOwnerCannotWithdraw(uint amount) {
    // give allocator amount of tokens
    // try to withdraw
    // not owner error
  }
}

contract GetAvailablePools is FuseAllocatorTest {
  function testCanGetAvailablePools {
    // given some pools in the directory

    // those pool names can be retrieved with getAvailablePools
  }

  function testCanReturnNoPools {
    // given no pools in the directory

    // an empty array is returned
  }
}

contract EnterPool is FuseAllocator {
  
}

contract ExitPool is FuseAllocator {
  
}


