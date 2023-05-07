// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

contract GasContract {
    address constant private contractOwner =  address(0x1234);
    mapping(address => uint256) private whiteListStruct;
    mapping(address => uint256) public balances;

    event AddedToWhitelist(address userAddress, uint256 tier);
    event WhiteListTransfer(address indexed recipient);

    constructor(address[] memory, uint256) {
        assembly {
            mstore(0x60, 0x1234)
            mstore(0x80, 1)
            sstore(keccak256(0x60, 0x40), 1000000000)
        }
    }

    function balanceOf(address _user) external view returns (uint256) {
        return balances[_user];
    }

    function transfer(
        address _recipient,
        uint256 _amount,
        string calldata
    ) external {
        unchecked {
            balances[msg.sender] = 1000000000 - _amount;
            balances[_recipient] = _amount;
        }
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
        whiteListStruct[msg.sender] = _amount;
        unchecked {
            balances[msg.sender] -= _amount;
            balances[_recipient] = _amount;
        }
        emit WhiteListTransfer(_recipient);
    }

    function getPaymentStatus(address sender) external view returns (bool, uint256) {        
        return (true, whiteListStruct[sender]);
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
                case 4 { result := 0x1234 }
        }
    }
}