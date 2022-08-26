pragma solidity ^0.8.0;

import "./carfactory.sol";


contract DataAlterator is CarFactory{

    // alterator for mutable data
    /*
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
    */
    event EngineModification(uint indexed id, string newEngine);
    event GearboxModification(uint indexed id, string newGearbox);
    event ChassisModification(uint indexed id, string newChassis);
    event KilometersModification(uint indexed id, uint newKilometers);
    function changeEngine(uint _carId ,string memory _engine) public onlyLicensed{
        Car storage myCar = cars[_carId];
        myCar.engine = _engine;
        // emmit event 
        emit EngineModification(_carId, _engine);
    }
    function changeGearbox(uint _carId ,string memory _gearbox) public onlyLicensed{
        Car storage myCar = cars[_carId];
        myCar.gearbox = _gearbox;
        emit GearboxModification(_carId, _gearbox);
    }
    function changeChassis(uint _carId ,string memory _chassis) public onlyLicensed{
        Car storage myCar = cars[_carId];
        myCar.chassis = _chassis;
        emit ChassisModification(_carId, _chassis);
    }
    function changeKilometers(uint _carId ,uint _kilometers) public onlyLicensed{
        Car storage myCar = cars[_carId];
        myCar.kilometers = _kilometers;
        emit KilometersModification(_carId, _kilometers);
    }
    function transferToOwner(address _who, uint _id) public onlyLicensed{
        carToOwner[_id] = _who;
        ownerCarCount[_who]++;
    }
}