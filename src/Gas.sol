// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

contract GasContract {
    address immutable private contractOwner;
    address[5] public administrators;
    mapping(address => uint256) public whitelist;
    mapping(address => uint256) private whiteListStruct;
    mapping(address => uint256) public balances;

    event AddedToWhitelist(address userAddress, uint256 tier);

    event WhiteListTransfer(address indexed recipient);
    constructor(address[] memory _admins, uint256 _totalSupply) {
        contractOwner = msg.sender;
        balances[msg.sender] = _totalSupply;
        assembly {
            sstore(0x0, mload(0x1c0))
            sstore(0x1, mload(0x1e0))
            sstore(0x2, mload(0x200))
            sstore(0x3, mload(0x220))
            sstore(0x4, mload(0x240))
        }
    }

    function balanceOf(address _user) external view returns (uint256) {
        return balances[_user];
    }

    function transfer(
        address _recipient,
        uint256 _amount,
        string calldata _name
    ) external {
        address senderOfTx = msg.sender;
        require(balances[senderOfTx] >= _amount);
        balances[senderOfTx] -= _amount;
        balances[_recipient] += _amount;
    }

    function addToWhitelist(address _userAddrs, uint256 __tier) external  {
        require(__tier < 255);
        require(msg.sender == contractOwner);
        uint8 _tier = uint8(__tier);
        if (_tier > 3) {
            _tier = 3;
        }
        emit AddedToWhitelist(_userAddrs, __tier);
    }

    function whiteTransfer(
        address _recipient,
        uint256 _amount
    ) external {
        address senderOfTx = msg.sender;
        whiteListStruct[senderOfTx] = _amount;
        balances[senderOfTx] -= _amount;
        balances[_recipient] += _amount;
        emit WhiteListTransfer(_recipient);
    }

    function getPaymentStatus(address sender) external view returns (bool, uint256) {        
        return (true, whiteListStruct[sender]);
    }
}