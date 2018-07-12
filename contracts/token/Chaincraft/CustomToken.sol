pragma solidity ^0.4.24;

import "./SubsidizedToken.sol";

/**
 * @title The default ERC20 Token, deployed from the Chaincraft interface
 *
 */

contract CustomToken is SubsidizedToken
{
    constructor() public payable {
        balances[msg.sender] = balances[msg.sender].add(totalSupply.sub(subsidy));
    }

    function () public payable {
        revert();
    }
}
