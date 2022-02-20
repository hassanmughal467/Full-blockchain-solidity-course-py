pragma solidity ^0.8.6;

// Fundamental of Solidity
contract SimpleStorage {
    uint256 FavoriteNum;
    struct Persons {
        string name;
        uint256 FavoriteNum;
        string class;
    }

    mapping(uint256 => string) public info;
    // way to initialize struct hard
    //Person public person=People({FavoriteNum:2,name:"hassan"});
    Persons[] public person;

    function Addperson(
        string memory _name,
        uint256 _FavNum,
        string memory _class
    ) public {
        person.push(Persons(_name, _FavNum, _class));
        info[_FavNum] = _name;
    }

    function store_id(uint256 _FavoriteNum) public {
        FavoriteNum = _FavoriteNum;
    }

    function retrieve() public view returns (uint256) {
        return FavoriteNum;
    }
}
