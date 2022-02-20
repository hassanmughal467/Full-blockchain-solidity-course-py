//SPDX-License-Identifier:MIT
pragma solidity >0.4.1 <0.9.0;

contract SimpleStorage {
    uint256 favnumbers;
    struct People {
        string name;
        uint256 favnumbers;
    }

    // we use mapping like we made dynamic array now we need to find fav number by entering name so we use mapping to solve this issue
    // like we need to find number from name so we use string to int for it in mapping
    mapping(string => uint256) public nametofavnum;

    People[] public people;

    function addpeople(string memory _name, uint256 _favnumber) public {
        people.push(People(_name, _favnumber));
        nametofavnum[_name] = _favnumber;
    }

    // Store Favorite Numbers
    function store(uint256 _favoritenumber) public {
        favnumbers = _favoritenumber;
    }

    // To retrieve favoriteNumber
    function retrieve() public view returns (uint256) {
        return favnumbers;
    }
}
