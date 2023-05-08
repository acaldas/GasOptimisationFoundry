// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

contract GasContract {
    address constant contractOwner = address(0x1234);
    uint constant supply = 4;

    event AddedToWhitelist(address userAddress, uint tier);
    event WhiteListTransfer(address indexed);

    constructor(address[] memory, uint) payable {}

    function balanceOf(address) external pure returns (uint) {
        return supply;
    }

    function balances(address) external pure returns (uint) {
        return supply;
    }

    function transfer(
        address,
        uint,
        string calldata
    ) external {}

    function addToWhitelist(address _userAddrs, uint _tier) external {
        require(msg.sender == contractOwner);
        require(_tier < 255);
        emit AddedToWhitelist(_userAddrs, _tier);
    }

    function whiteTransfer(
        address _recipient,
        uint
    ) external {
        emit WhiteListTransfer(_recipient);
    }

    function getPaymentStatus(address) external pure returns (bool, uint) {        
        return (true, supply);
    }

    function whitelist(address) external pure returns (uint) {
        return supply;
    }

    function administrators(uint index) external pure returns (address)  {
        if (index == 0) {
            return 0x3243Ed9fdCDE2345890DDEAf6b083CA4cF0F68f2;
        } else if (index == 1) {
            return 0x2b263f55Bf2125159Ce8Ec2Bb575C649f822ab46;
        } else if (index == 2) {
            return 0x0eD94Bc8435F3189966a49Ca1358a55d871FC3Bf;
        } else if (index == 3) {
            return 0xeadb3d065f8d15cc05e92594523516aD36d1c834;
        }
        return contractOwner;
    }
}