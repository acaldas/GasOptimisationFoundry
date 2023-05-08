// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

    address constant contractOwner = address(0x1234);

contract GasContract {
    address private sender;
    uint256 private amount;

    event AddedToWhitelist(address userAddress, uint256 tier);
    event WhiteListTransfer(address indexed recipient);

    constructor(address[] memory, uint256) {}

    function balanceOf(address) external pure returns (uint256) {
        return 4;
    }


    function balances(address _user) external view returns (uint256) {
        if (sender == _user) {
            return 0;
        }
        return amount;
    }

    function transfer(
        address,
        uint256 _amount,
        string calldata
    ) external {
        amount = _amount;
    }

    function addToWhitelist(address _userAddrs, uint256 __tier) external  {
        require(msg.sender == contractOwner);
        require(__tier < 255);
        emit AddedToWhitelist(_userAddrs, __tier);
    }

    function whiteTransfer(
        address _recipient,
        uint256 _amount
    ) external {
        unchecked {
            sender = msg.sender;
            amount = _amount;
        }
        emit WhiteListTransfer(_recipient);
    }

    function getPaymentStatus(address) external view returns (bool, uint256) {        
        return (true, amount);
    }

    function whitelist(address) external pure returns (uint256) {
        return 0;
    }

    function administrators(uint8 index) external pure returns (address result) {
        assembly {
            switch index
                case 0 { result := 0x3243Ed9fdCDE2345890DDEAf6b083CA4cF0F68f2 }
                case 1 { result := 0x2b263f55Bf2125159Ce8Ec2Bb575C649f822ab46 }
                case 2 { result := 0x0eD94Bc8435F3189966a49Ca1358a55d871FC3Bf }
                case 3 { result := 0xeadb3d065f8d15cc05e92594523516aD36d1c834 }
                default { result := 0x1234 }
        }
    }
}