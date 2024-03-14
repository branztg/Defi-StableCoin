// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {ERC20Burnable,ERC20} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {Ownable} from "openzeppelin-contracts/contracts/access/Ownable.sol";


contract StableCoin is ERC20Burnable, Ownable {


    error StableCoinError_CannotBurnZero();
    error StableCoinError_CannotBurnMoreThanYourBalance();
    error StableCoinError_CannotMintToZeroAddress();
    error StableCoinError_CannotMintZero();

    constructor() ERC20('DecentralizedStableCoin','DSC') Ownable(0xf3202F9c5334cd5f6dEBD2e939B9C52967EEbf29) {}


    function burn(uint256 value) public override onlyOwner {
        uint256 balance = balanceOf(msg.sender);

        if (value <= 0) {
            revert StableCoinError_CannotBurnZero();
        }
        if (balance < value) {
            revert StableCoinError_CannotBurnMoreThanYourBalance();
        }
        super.burn(value);
    }

    function mint(address _to, uint256 _amount) external onlyOwner returns(bool) {

        if(_to == address(0)) {
            revert StableCoinError_CannotMintToZeroAddress();
        }
        if(_amount <= 0) {
            revert StableCoinError_CannotMintZero();
        }
        _mint(_to, _amount);
        return true;
    }











}
