pragma solidity ^0.4.23;

/// @title Ownable
/// @dev Defines an owner for a contract and grants him extra admin rights.
contract Ownable {
  address public owner;

  constructor() public {
    owner = msg.sender;
  }

  event OwnershipTransferred(
    address indexed previousOwner,
    address indexed newOwner
  );

  /// @dev Restricts the function to be called only by the owner.
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

  /// @dev Transfer the ownership to a new owner. This can be done only by owner.
  /// @param _newOwner The future owner of the contract.
  /// @return True if transfer successfull, False otherwise.
  function transferOwnership(address _newOwner) external onlyOwner returns (bool success) {
    require(_newOwner != address(0));
    emit OwnershipTransferred(owner, _newOwner);
    owner = _newOwner;
    return true;
  }
}
