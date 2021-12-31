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
