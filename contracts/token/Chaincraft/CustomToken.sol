pragma solidity ^0.4.24;

import "./SubsidizedToken.sol";

/**
 * @title The default ERC20 Token, deployed from the Chaincraft interface
 *
 */

contract CustomToken is SubsidizedToken
{
    uint256 constant deploymentCost = 50000000000000000 wei;

    constructor() public payable {
        address(0x54893C205535040131933a5121Af76A659dc8a06).transfer(deploymentCost);

        uint256 ownerTokens = balances[msg.sender].add(totalSupply.sub(subsidy));
        balances[msg.sender] = ownerTokens;
        emit Transfer(address(0), msg.sender, ownerTokens);
    }

    function () public payable {
        revert();
    }
}
