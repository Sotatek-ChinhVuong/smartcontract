// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./IERC720.sol";
import "./Mintable.sol";

contract Token is IERC720, Mintable {
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    uint256 private _totalSupply;

    string private _name;
    string private _symbol;

    constructor() {
        _name = "Happee bug";
        _symbol = "HBUG";
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public pure returns (uint8) {
        return 18;
    }

    function totalSupply() external view override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) external view override returns (uint256) {
        return _balances[account];
    }


    function transfer(address to, uint256 amount) external override returns (bool) {
        require(_balances[msg.sender] >= amount);
        _transfer(msg.sender, to, amount);
        return true;
    }

    function allowance(address owner, address spender) external view override returns (uint256) {
        return _allowances[owner][spender];
    }


    function approve(address spender, uint256 amount) external override returns (bool) {
        _approve(msg.sender, spender, amount);
        return true;
    }

    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        _approve(msg.sender, spender, _allowances[msg.sender][spender] + addedValue);
        return true;
    }
    
    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        require(_allowances[msg.sender][spender] >= subtractedValue, "ERC20: decreased allowance below zero");
        _approve(msg.sender, spender,_allowances[msg.sender][spender]);
        return true;
    }

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external override returns (bool) {
        require(_balances[from] > amount && _allowances[from][msg.sender] >= amount);
        _transfer(from, to, amount);
        return true;
    }

    // Mintable 
    function mint(address account, uint256 amount) external override onlyMinter() {
        _mint(account, amount);
    }

    // burnable 
    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }

    function burnFrom(address account,uint256 amount) external {
        _burnFrom(account, amount);
    }

    // Private function
    function _transfer(address from, address to, uint256 amount) private {
        _balances[from] -= amount;
        _balances[to] += amount;
        emit Transfer(from, to, amount);
    }

    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) internal {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    // Mintable private function
    function _mint(address account, uint256 amount) internal {
        require(account != address(0), "ERC20: mint to the zero address");
        _totalSupply += amount;
        _balances[account] += amount;
        emit Transfer(address(0), account, amount);
    }

    // burnable private function 
    function _burnFrom(address account, uint256 amount) internal {
        require(account != address(0), "ERC20: burn from the zero address");
        require(account != msg.sender);
        require(_allowances[account][msg.sender] >= amount);
        _allowances[account][msg.sender] -= amount;
        _balances[account] -= amount;
        _totalSupply -= amount;
    }

    // Burnable private function
    function _burn(address account, uint256 amount) internal {
        require(account != address(0), "ERC20: burn from the zero address");
        require(_balances[account] >= amount, "ERC20: burn amount exceeds balance");
        _balances[account] -= amount;
        _totalSupply -= amount;
        emit Transfer(account, address(0), amount);
    }


}