pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./dataalterator.sol";

/*
  contract ERC721 {
  event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);
  event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);

  function balanceOf(address _owner) external view returns (uint256);
  function ownerOf(uint256 _tokenId) external view returns (address);
  function transferFrom(address _from, address _to, uint256 _tokenId) external payable;
  function approve(address _approved, uint256 _tokenId) external payable;
}
*/

contract NftStandard is DataAlterator, ERC721{

   constructor() ERC721("Car", "CAR") {
    }

    mapping (uint => address) carApprovals;

  function balanceOf(address _owner) public view override returns (uint256) {
    return ownerCarCount[_owner];
  }

  function ownerOf(uint256 _tokenId) public view override returns (address) {
    return carToOwner[_tokenId];
  }

   function transfer(address _from, address _to, uint256 _tokenId) private {
    ownerCarCount[_to]++;
    ownerCarCount[_from]--;
    carToOwner[_tokenId] = _to;
    emit Transfer(_from, _to, _tokenId);
  }

  function transferFrom(address _from, address _to, uint256 _tokenId) public override {

    require(carToOwner[_tokenId] == msg.sender || carApprovals[_tokenId] == msg.sender);
    transfer(_from,_to,_tokenId);
  }

  function approve(address _approved, uint256 _tokenId) public override {
    carApprovals[_tokenId] = _approved;
    emit Approval(msg.sender,_approved,_tokenId);

  }

}