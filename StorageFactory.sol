//SPDX-License-Identifier:MIT
// W learn in this how to interact with another contract and their functionality
pragma solidity ^0.8.10;

import "./SimpleStorage.sol"; 

contract StorageFactory 
{
     SimpleStorage[] public simplestorageArray;

    function createSimpleStorageContract() public 
    {
        SimpleStorage simplestorage=new SimpleStorage();
        simplestorageArray.push(simplestorage);
    }
    function sfstore(uint256 _simpleStorageindex,uint256 _simplestorageNumber) public 
    {
        //Address 
        //ABI
       SimpleStorage(address(simplestorageArray[_simpleStorageindex])).store(_simplestorageNumber);
    }

    function  sfget(uint256 _simplestorageindex) public view returns(uint256)
    {
        return SimpleStorage(address(simplestorageArray[_simplestorageindex])).retrieve();
    }
  
}