
pragma solidity ^0.8.4;

import "./CoinInterface.sol";

contract SaliCoin is CoinInterface{
    
    uint256 constant private MAX_UINT256 = 2 ** 256 - 1;
    
    //mapping
    mapping (address => uint256) public balances; //map balances of each address
    mapping (address => mapping (address => uint256)) public allowed; //map allowed addresses
    
    string public name;
    uint8 public decimals;
    string  public symbol;
    uint256 initialAmmount;
    
    constructor () {
        //Token data 
        name = "Sali Coin";
        decimals = 0;
        symbol = "SALI";
        initialAmmount = 10000000;
        totalSupply = initialAmmount;
        balances[msg.sender] = initialAmmount; //Give all initial supply to the owner
    }
    
    //Transfer
    function transfer(address _to, uint256 _value) public override returns (bool success){
        
        //Check if sender has sufficient balance
        require(balances[msg.sender] >= _value);
        
        //Reduce sent ammount from the sender
        balances[msg.sender] -= _value;
        
        //Add recived ammount to the recievers account
        balances[_to] += _value;
        
         emit Transfer(msg.sender, _to, _value);
        
        return true;
    }
    
    //From
    function transferFrom(address _from, address _to, uint256 _value) public override returns (bool success){
        uint256 allowedAmount = allowed[_from][msg.sender];
        
        ///Check balance
        require(balances[_from] >= _value && (allowedAmount >= _value));
        
        //Transaction
        balances[_to] += _value;
        balances[_from] -= _value;
        
        if(allowedAmount < MAX_UINT256){
            allowed[_from][msg.sender] -= _value;
        }
        
        //Broadcast
        emit Transfer(_from, _to, _value);
        return true;
    }
    
    //Get approval
    function approve(address _spender, uint256 _value) public override returns (bool success){
        allowed[msg.sender][_spender] = _value;
        
        //broadcast
        emit Approval(msg.sender, _spender, _value);
        return true;
    }
    
    //Check allowance
    function allowance(address _owner, address _spender) public override view returns (uint256 remainingTokens){
       return allowed[_owner][_spender];
    }
    
    //Rteurn balance
    function balanceOf(address _owner) public override view returns (uint256 balance){
        return balances[_owner];
    }
}


// SPDX-License-Identifier: MIT
