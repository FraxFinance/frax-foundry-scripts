// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "frax-std/FraxTest.sol";
import "src/contracts/Counter.sol";

contract TestIncrement is FraxTest {
    Counter public counter;

    function setUp() public {
        setupFunctions.push(defaultSetup);
        setupFunctions.push(anotherSetup);
        addSetupFunctions(setupFunctions);
    }

    function defaultSetup() public {
        counter = new Counter();
        counter.setNumber(0);
    }

    function anotherSetup() public {
        counter = new Counter();
        counter.setNumber(50);
    }

    function testSetNumber(uint256 x) public useMultipleSetupFunctions {
        counter.setNumber(x);
        assertEq(counter.number(), x);
    }
}
