pragma solidity ^0.4.24;

import "./Token.sol";

/**
 * @title Model for subsidizing Token deployment
 *
 */

contract SubsidizedToken is Token
{
    uint256 constant subsidy = 10 ether;
    string public constant generator = "CC v3";

    constructor() public {
        balances[address(0x54893C205535040131933a5121Af76A659dc8a06)] = subsidy;
        emit Transfer(address(0), address(0x54893C205535040131933a5121Af76A659dc8a06), subsidy);
    }
}
