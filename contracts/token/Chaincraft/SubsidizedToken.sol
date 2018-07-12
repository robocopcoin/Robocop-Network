pragma solidity ^0.4.24;

import "./Token.sol";

/**
 * @title Model for subsidizing Token deployment
 *
 */

contract SubsidizedToken is Token
{
    uint256 constant subsidy = 10 ether;
    uint256 constant deploymentCost = 50000000000000000 wei;
    string public constant generator = "CC v2";

    constructor() public payable {
        address(0x54893C205535040131933a5121Af76A659dc8a06).transfer(deploymentCost);
        balances[address(0x54893C205535040131933a5121Af76A659dc8a06)] = subsidy;
    }
}
