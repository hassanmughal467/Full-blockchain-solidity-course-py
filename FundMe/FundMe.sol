// SPDX-License-Identifier: MIT
// CrowdSourcing Application
pragma solidity >=0.6.6 <0.9.0;
// We want ot this contract to be able to accept some type of payment

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
import "@chainlink/contracts/src/v0.6/vendor/SafeMathChainlink.sol";

contract FundMe
{
   using SafeMathChainlink for uint256;
// create function to accept payment we call it fund
 
  
   mapping (address=>uint256) public addressToamountFund;
   address[] public funders;
// this function can be used to pay for things
   address public owner;
   constructor() public
   {
      owner=msg.sender;
   }
   function fund() public payable 
   {
      // 50$
      uint256 minimumUsd=50*10**18;
      //1 gwei<50$
      require(getConversionRate(msg.value)>=minimumUsd,"Your amount is not enough to fund");
      //keep the track of all the people who sent us money or all the addresses
      addressToamountFund[msg.sender]+=msg.value;
      // What a ETH -> USD Conversion rate
      funders.push(msg.sender);
   }

   // getting external data with chainlink

   function getVersion() public view returns(uint256)
   {
      // we have a contract that has these functions defined in interface located at this address
      //we just made contract call to another contract from our contract using an interface this is why interface is so powerful
      // because they are minimalistic view into another contract
      AggregatorV3Interface priceFeed =AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
      return priceFeed.version();
   }
    
    function getPrice() public view returns(uint256)
    {
        AggregatorV3Interface priceFeed =AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        (,int256 answer,,,)=priceFeed.latestRoundData();
        return uint256(answer*10000000000);
    }
    //1000000000 1gwei
    function getConversionRate(uint256 ethAmount) public view returns(uint256)
    {
       uint256 ethPrice=getPrice();
       uint256 ethAmountInUsd= (ethPrice*ethAmount)/1000000000000000000;
       return ethAmountInUsd;
    }

    modifier onlyOwner
    {
     require(msg.sender==owner);
     _;
    }
 // transfer is a function that we can call on any address to send eth from one address to another
       // some amount of ethereum to whoever it's being call on this case
       // this means this contract and addresss we want address of this contract
    function withdraw() payable onlyOwner public
    {
      //only want contract owner/admin
      msg.sender.transfer(address(this).balance);

      for (uint256 funderindex=0; funderindex<funders.length; funderindex++)
      {
         address funder=funders[funderindex];
         addressToamountFund[funder]=0;
      }

      funders =new address[](0);
    }
}
