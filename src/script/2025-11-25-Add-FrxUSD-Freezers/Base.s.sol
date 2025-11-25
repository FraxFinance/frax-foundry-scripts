pragma solidity ^0.8.0;

import { BaseScript } from "frax-std/BaseScript.sol";
import { console } from "frax-std/FraxTest.sol";
import { SafeTx, SafeTxHelper } from "frax-std/SafeTxHelper.sol";

interface ISafe {
    function getOwners() external view returns (address[] memory);
}

interface IFrxUSD {
    function addFreezer(address freezer) external;
}

// forge script src/script/2025-11-25-Add-FrxUSD-Freezers/Base.s.sol --rpc-url https://mainnet.base.org
contract AddFrxUsdFreezers is BaseScript {
    address public msig = 0xCBfd4Ef00a8cf91Fd1e1Fe97dC05910772c15E53;
    address public frxUsd = 0xe5020A6d073a794B6E7f05678707dE47986Fb0b6;

    SafeTx[] internal txs;

    function run() public {
        address[] memory owners = ISafe(msig).getOwners();

        for (uint256 i = 0; i < owners.length; i++) {
            addFreezer(owners[i]);
        }

        // dennis
        addFreezer(0xC6EF452b0de9E95Ccb153c2A5A7a90154aab3419);

        // save to file
        SafeTxHelper helper = new SafeTxHelper();
        helper.writeTxs(
            txs,
            string(abi.encodePacked(vm.projectRoot(), "/src/script/2025-11-25-Add-FrxUSD-Freezers/txs/Base.json"))
        );
    }

    function addFreezer(address freezer) internal {
        bytes memory data = abi.encodeCall(IFrxUSD.addFreezer, (freezer));

        vm.prank(msig);
        (bool success, ) = frxUsd.call(data);
        require(success, "frxUSD: addFreezer failed");

        txs.push(SafeTx({ name: "Add Freezer", to: frxUsd, value: 0, data: data }));
    }
}
