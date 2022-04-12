// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Mintable {
    mapping(address => bool) private _minter;
    event MinterAdded(address account);
    event MinterRemoved(address account);
    modifier onlyMinter() {
        require(_minter[msg.sender] == true);
        _;
    }

    function isMinter (address account) view external returns(bool) {
        return _minter[account];
    }

    function addMinter(address account) public {
        _addMinter(account);

    }

    function renounceMinter() public onlyMinter() {
         _removeMinter(msg.sender);
    }

    function _addMinter(address account) private {
        _minter[account] = true;
        emit MinterAdded(account);
    }

    function _removeMinter(address account) private {
         _minter[account] = false;
         emit MinterRemoved(account);
    }

    function mint(address account, uint256 amount) external virtual {}

}