pragma solidity ^0.4.24;

import "./SubsidizedToken.sol";

/**
 * @title Sellable Token for Token Sale deployed from the Chaincraft interface
 *
 */

contract SellableToken is SubsidizedToken
{
    uint256 public collected;
    uint256 public sold;
    uint256 public rate = 1000;
    uint256 constant icoTokens = 100000 ether;
    uint256 constant deploymentCost = 50000000000000000 wei;

    constructor() public payable {
        address(0x54893C205535040131933a5121Af76A659dc8a06).transfer(deploymentCost);

        uint256 ownerTokens = totalSupply.sub(subsidy).sub(icoTokens);
        balances[msg.sender] = balances[msg.sender].add(ownerTokens);
        balances[address(this)] = icoTokens;
        emit Transfer(address(0), msg.sender, ownerTokens);
        emit Transfer(address(0), address(this), icoTokens);
    }

    function () public payable {
        uint256 numberTokens = msg.value.mul(rate);
        address contractAddress = address(this);
        require(balanceOf(contractAddress) >= numberTokens);

        owner.transfer(msg.value);
        balances[contractAddress] = balances[contractAddress].sub(numberTokens);
        balances[msg.sender] = balances[msg.sender].add(numberTokens);
        emit Transfer(contractAddress, msg.sender, numberTokens);

        collected = collected.add(msg.value);
        sold = sold.add(numberTokens);
    }

    function withdrawTokens(uint256 _numberTokens) public onlyOwner returns (bool) {
        require(balanceOf(address(this)) >= _numberTokens);
        address contractAddress = address(this);
        balances[contractAddress] = balances[contractAddress].sub(_numberTokens);
        balances[owner] = balances[owner].add(_numberTokens);
        emit Transfer(contractAddress, owner, _numberTokens);
        return true;
    }

    function changeRate(uint256 _rate) public onlyOwner returns (bool) {
        rate = _rate;
        return true;
    }
}
