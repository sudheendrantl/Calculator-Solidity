// SPDX-License-Identifier: MIT
// import the needed files 

pragma solidity ^0.8 ; // Using Solidity 8 

contract First{

    uint8 public no1;
    uint8 public no2;
    uint ans;

    constructor (uint8 x, uint8 y){
        no1 = x;
        no2 = y;
    }

    function set (uint8 x, uint8 y) public {
        no1 = x;
        no2 = y;
    }

    function mul() public {
        ans = uint(no1) * uint(no2);
    }

    function div() public checkifnonzero{
        //require(no2!=0,"The second number should not be zero");
        ans = uint(no1) / uint(no2);
    }

    function add() public {
        ans = uint(no1) + uint(no2);
    }

    function sub() public {
        require(no1>=no2,"The second nubmer has to be smaller");
        ans = uint(no1) - uint(no2);
    }

    function mod() public checkifnonzero{
        //require(no2!=0,"The second number should not be zero");
        ans = uint(no1) % uint(no2);
    }

    function square(uint x) public pure checkifeven(x) returns (uint) {
        return x*x;
    }

    function getresult() public view returns(uint){
        return ans;
    }

    modifier checkifeven(uint a){
        require(a%2==0,"Only Even Numbers will be squared...");
        _;
    }
    modifier checkifnonzero(){
      require(no2!=0,"The second number should not be zero");
      _;  
    }
}