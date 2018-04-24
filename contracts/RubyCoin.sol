pragma solidity ^0.4.23;

import "./ownership/Ownable.sol";

/// @title RubyCoin Contract
/// @dev This contract's goal is to provide a simple, working implementation of
///  ERC-20 token in order to be used with a Ruby frontend!
contract RubyCoin is Ownable {
  /// @dev Stores the balance for every account.
  mapping (address => uint) balances;
  /// @dev Stores the allowance for every account.
  ///   Allowance is stored as (SpenderAddress => ValueAllowedToSpent).
  mapping (address => mapping (address => uint)) withdrawAllowance;

  event Transfer(
    address indexed _from,
    address indexed _to,
    uint _value
  );

  event Approval(
    address indexed _owner,
    address indexed _spender,
    uint _value
  );

  struct Semver {
    uint major;
    uint minor;
    uint patch;
  }

  Semver public version; // Version of the contract, following Semver.
  string public name;
  string public symbol;
  uint8  public decimals;

  constructor(
    address _owner,
    uint _major,
    uint _minor,
    uint _patch
  ) Ownable(_owner) public {
    version = Semver(_major, _minor, _patch);
    name = "RubyCoin";
    symbol = "RBC";
    decimals = 6;
  }

  /// @dev Returns the total supply of existing token.
  function totalSupply() public view returns (uint) {
    return 1e9;
  }

  /// @dev Returns the balance of tokens of someone.
  /// @param _owner The person you want to check balance.
  function balanceOf(address _owner) public view returns (uint) {
    return balances[_owner];
  }

  /// @dev Transfer some token to someone else.
  /// @param _to The receiver of transfer.
  /// @param _value The amount to transfer.
  /// @return True if transfer is successfull, False otherwise.
  function transfer(address _to, uint _value) public returns (bool success) {
    if (balances[msg.sender] < _value) {
      revert();
    } else {
      balances[msg.sender] -= _value;
      balances[_to] += _value;
      emit Transfer(msg.sender, _to, _value);
      return true;
    }
  }

  /// @dev Approve a third party to withdraw a certain amount of tokens for the owner.
  /// @param _spender The future approved spender.
  /// @param _value The maximum value the spender will be able to withdraw.
  /// @return True if approving successfull, False otherwise.
  function approve(address _spender, uint _value) public returns (bool success) {
    withdrawAllowance[msg.sender][_spender] = _value;
    emit Approval(msg.sender, _spender, _value);
    return true;
  }

  /// @dev Transfer some tokens form one account to the other if previously approved.
  /// @param _from The account to send from.
  /// @param _to The account to send to.
  /// @param _value The amount to send.
  /// @return True if transfer successfull, False otherwise.
  function transferFrom(
    address _from,
    address _to,
    uint _value
  ) public onlyOwner returns (bool success) {
    if (withdrawAllowance[_from][msg.sender] < _value) {
      revert();
    } else {
      withdrawAllowance[_from][msg.sender] -= _value;
      balances[_to] += _value;
      balances[_from] -= _value;
      emit Transfer(_from, _to, _value);
      return true;
    }
  }

  /// @dev Returns the amount a spender can withdraw for another account.
  /// @param _owner The account to spend from.
  /// @param _spender The account allowed to spend.
  /// @return The total amount remaining to spend for spender.
  function allowance(
    address _owner,
    address _spender
  ) public view returns (uint remaining) {
    return withdrawAllowance[_owner][_spender];
  }
}
