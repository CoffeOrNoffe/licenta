pragma solidity ^0.8.0;

import "./carfactory.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CarHelper is Ownable{

    mapping (address => bool) licensedWallets;

    event newLicensedWallet(address indexed wallet);
    event removedLicensedWallet( address indexed wallet);

    function addLicensedWallet(address _who) public onlyOwner{
        licensedWallets[_who] = true;
        // emit event
        emit newLicensedWallet(_who);
    }

    function removeLicensedWallet(address _who) public onlyOwner{
        licensedWallets[_who] = false;
        // emit event
        emit removedLicensedWallet(_who);
    }

    // modifiers for licensed wallets
    modifier onlyLicensed{
        require(licensedWallets[msg.sender], "You are not authorized");
        _;
    }


}