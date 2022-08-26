pragma solidity ^0.8.0;


import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./carhelper.sol";

contract CarFactory is CarHelper{

    
    using SafeMath for uint256;

    struct Car{
        // immutable
        string brand;
        string model;
        uint year;
        // mutable
        string engine;
        string gearbox;
        string chassis;
        uint kilometers;
    }
    Car[] public cars; // list of all the cars

    mapping(uint => address) public carToOwner;
    mapping(address => uint) public ownerCarCount;

    event NewCar(string brand, string model, uint year, string engine, string gearbox, string chassis, uint kilometers, address indexed owner);
    // future work => emmit events with indexing all the other attributes to allow for easy search for statistics maybe ? 

    // pass all the data, set mappings
    function _createCar(string memory _brand, 
                        string memory _model, 
                        uint _year,
                        string memory _engine,
                        string memory _gearbox,
                        string memory _chassis,
                        uint _kilometers ) public onlyLicensed{

        cars.push(Car(_brand, _model, _year, _engine, _gearbox, _chassis, _kilometers));
        uint id = cars.length - 1;
        carToOwner[id] = msg.sender;
        ownerCarCount[msg.sender] =  ownerCarCount[msg.sender].add(1);

    } 
}