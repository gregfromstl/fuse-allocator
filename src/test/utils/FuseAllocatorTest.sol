// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;
import "ds-test/test.sol";

import "../../FuseAllocator.sol";
import "../../FusePoolDirectory.sol";
import "./Hevm.sol";

contract User {
  FuseAllocator internal allocator;

  constructor(address _allocator) {
    allocator = FuseAllocator(_allocator);
  }

  function setDirectory(address directory) public {
    allocator.setDirectory(directory);
  }

  function getDirectory() public view returns (FusePoolDirectory) {
    return allocator.directory();
  }
}

abstract contract FuseAllocatorTest is DSTest {
  Hevm internal constant hevm = Hevm(HEVM_ADDRESS);

  // contracts
  FuseAllocator internal allocator;

  // users
  User internal alice;
  User internal bob;

  function setUp() public virtual {
    allocator = new FuseAllocator();
    alice = new User(address(allocator));
    bob = new User(address(allocator));
    allocator.transferOwnership(address(alice));
  }
}
