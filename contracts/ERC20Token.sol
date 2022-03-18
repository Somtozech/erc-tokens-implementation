// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract ERC20Token is ERC20 {
    using SafeMath for uint256;

    constructor(uint256 _initialSupply) ERC20("ERC20Token", "ERT") {
        _mint(msg.sender, _initialSupply * 10**decimals());
    }

    function buyToken() public payable {
        require(msg.value > 0, "Insufficient ether received");

        uint256 tokenAmount = msg.value.div(1000);

        _mint(msg.sender, tokenAmount * 10**decimals());
    }
}
