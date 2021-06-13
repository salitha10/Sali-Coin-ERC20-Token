
pragma solidity ^0.8.4; ///Version

//Contract 
abstract contract CoinInterface{
    
    /***
     * Different from ERC20 interface
    */
    
    uint256 public totalSupply;  //Total number of tokens
    
    //@return balaance
    function balanceOf(address _owner) public virtual view returns (uint256 balance);
    
    
    //send tokens _to
    //@return success state
    function transfer(address _to, uint256 _value) public virtual returns (bool success);
    
    
    //send tokens _from
    //@returns success state
    function transferFrom(address _from, address _to, uint256 _value) public virtual returns (bool success);
    
    
    //check for ability to transfer
    //@returns success state
    function approve(address _spender, uint256 _value) public virtual returns (bool success);
    
    
    //balance in the senders wallet
    function allowance(address _owner, address _spender) public virtual view returns (uint256 remainingTokens);
    
    
    //events
    event Transfer(address indexed _from, address indexed _to, uint256 _value); //Transfer event
    event Approval(address indexed _owner, address indexed _spender, uint256 _value); //Approval event
    
}

// SPDX-License-Identifier: MIT


