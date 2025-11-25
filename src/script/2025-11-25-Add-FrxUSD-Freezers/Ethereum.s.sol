pragma solidity ^0.8.0;

import { BaseScript } from "frax-std/BaseScript.sol";
import { console } from "frax-std/FraxTest.sol";
import { IFrxUSD } from "frax-tokens/contracts/ethereum/frxUSD/IFrxUSD.sol";

interface ISafe {
    function getOwners() external view returns (address[] memory);
}

contract AddFrxUsdFreezersEthereum is BaseScript {
    address public msig = 0xB1748C79709f4Ba2Dd82834B8c82D4a505003f27;
    address public frxUsd = 0xCAcd6fd266aF91b8AeD52aCCc382b4e165586E29;
}
