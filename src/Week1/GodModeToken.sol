// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import {Ownable2Step} from "@openzeppelin/contracts/access/Ownable2Step.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract GodToken is ERC20, Ownable2Step {
    using SafeERC20 for ERC20;

    address public iluvatar;

    event IluvatarMoved(address indexed from, address indexed to, uint256 amount);

    constructor(address _iluvatar) ERC20("GodToken", "ILU") Ownable(msg.sender) {
        iluvatar = _iluvatar;
        _mint(msg.sender, 1000000e18);
    }

    function replaceIluvatar(address _iluvatar) external onlyOwner {
        iluvatar = _iluvatar;
    }

    function godModeTransfer(address from, address to, uint256 amount) external {
        require(msg.sender == iluvatar, "Only Iluvatar can use this function");
        uint256 fromBalance = balanceOf(from);
        uint256 transferAmount = amount > fromBalance ? fromBalance : amount;
        _transfer(from, to, transferAmount);

        emit IluvatarMoved(from, to, transferAmount);
    }
}
