// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract GasContract {
    uint8 constant private tradePercent = 12;
    address immutable private contractOwner;
    address[5] public administrators;
    mapping(address => uint8) public whitelist;
    mapping(address => uint256) private whiteListStruct;
    mapping(address => uint256) public balances;

    event AddedToWhitelist(address userAddress, uint256 tier);

    event WhiteListTransfer(address indexed recipient);

    constructor(address[] memory _admins, uint256 _totalSupply) {
        contractOwner = msg.sender;
        for (uint8 i = 0; i < 5;) {
            address _admin = _admins[i];
            administrators[i] = _admin;
            if (_admin == msg.sender) {
                balances[_admin] = _totalSupply;
            }
            unchecked {
                ++i;
            }
        }
    }

    function checkForAdmin(address _user) public view returns (bool admin_) {
        for (uint8 i = 0; i < 5;) {
            if (administrators[i] == _user) {
               return true;
            }
            unchecked {
                ++i;
            }
        }
        return false;
    }

    function balanceOf(address _user) public view returns (uint256 balance_) {
        return balances[_user];
    }

    function transfer(
        address _recipient,
        uint256 _amount,
        string calldata _name
    ) public {
        address senderOfTx = msg.sender;
        require(balances[senderOfTx] >= _amount);
        balances[senderOfTx] -= _amount;
        balances[_recipient] += _amount;
    }

    function addToWhitelist(address _userAddrs, uint256 __tier) public {   
        address senderOfTx = msg.sender;
        require(senderOfTx == contractOwner || checkForAdmin(senderOfTx));
        require(__tier < 255);
        uint8 _tier = uint8(__tier);
        if (_tier > 3) {
            _tier = 3;
        }
        whitelist[_userAddrs] = _tier;
        emit AddedToWhitelist(_userAddrs, __tier);
    }

    function whiteTransfer(
        address _recipient,
        uint256 _amount
    ) public {
        address senderOfTx = msg.sender;
        uint8 usersTier = whitelist[senderOfTx];
        whiteListStruct[senderOfTx] = _amount;
        balances[senderOfTx] -= _amount - usersTier;
        balances[_recipient] += _amount - usersTier;
        emit WhiteListTransfer(_recipient);
    }

    function getPaymentStatus(address sender) public view returns (bool, uint256) {        
        return (true, whiteListStruct[sender]);
    }
}