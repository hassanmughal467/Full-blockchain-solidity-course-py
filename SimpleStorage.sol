//SPDX-License-Identifier:MIT
pragma solidity ^0.8.10;

contract struts_array
{
    struct People
    {
        string name;
        uint favnumber;
    
    }
// we use mapping like we made dynamic array now we need to find fav number by entering name so we use mapping to solve this issue
// like we need to find number from name so we use string to int for it in mapping
    mapping(string=>uint256) public nametofavnum;

    People[] public people;

    function addpeople(string memory _name,uint256 _favnumber) public
    {
        people.push(People(_name,_favnumber));
        nametofavnum[_name]=_favnumber;

    }

}