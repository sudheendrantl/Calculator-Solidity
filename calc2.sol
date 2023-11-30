// SPDX-License-Identifier: MIT

pragma solidity ^0.8 ; // Using Solidity 8 

contract Third{

    uint8 public no1;
    uint8 public no2;
    uint public ans;
    string public name;
    bool valset = false;

    function set (uint8 x, uint8 y) public {
        no1 = x;
        no2 = y;
        valset = true;
    }

    function mul() public {
        require(valset==true,"set values for no1 and no2");
        ans = uint(no1) * uint(no2);
    }

    function div() public checkifnonzerodivisor {
        require(valset==true,"set values for no1 and no2");
        ans = uint(no1) / uint(no2);
    }

    function add() public {
        require(valset==true,"set values for no1 and no2");
        ans = uint(no1) + uint(no2);
    }

    function sub() public {
        require(valset==true,"set values for no1 and no2");
        require(no1>=no2,"The second nubmer has to be smaller");
        ans = uint(no1) - uint(no2);
    }

    function mod() public checkifnonzerodivisor {
        require(valset==true,"set values for no1 and no2");
        ans = uint(no1) % uint(no2);
    }

    function square(uint x) public pure checkifeven(x) returns (uint) {
        return pow(x,2);
    }

    function factorial(uint8 n) public pure returns(uint){
        require(n>0, "Number cannot be 0");
        require(n<=10, "Number <=10 only supported");
        if (n == 1) {
            return 1;
        }
        return n * factorial(n-1);
    }

    function pow(uint a, uint b) public pure returns(uint){
        require(a<=10, "base cannot be >10");
        require(b<=5, "exponent cannot be >5");
        return a ** b;
    }

    function and(bytes1 a, bytes1 b) public pure returns(bytes1){
        return a&b;
    }

    function or(bytes1 a, bytes1 b) public pure returns(bytes1){
        return a|b;
    }

    function xor(bytes1 a, bytes1 b) public pure returns(bytes1){
        return a^b;
    }

    function not(bytes1 a) public pure returns(bytes1){
        return ~a;
    }

    function nand(bytes1 a, bytes1 b) public pure returns(bytes1){
        return not(and(a,b));
    }

    function nor(bytes1 a, bytes1 b) public pure returns(bytes1){
        return not(or(a,b));
    }

    function xnor(bytes1 a, bytes1 b) public pure returns(bytes1){
        return not(xor(a,b));
    }

    function sleft(bytes1 a, uint8 b) public pure returns(bytes1){
        return a<<b;
    }

    function sright(bytes1 a, uint8 b) public pure returns(bytes1){
        return a>>b;
    }

    modifier checkifeven(uint a){
        require(a%2==0,"Only Even Numbers will be squared...");
        _;
    }

    modifier checkifnonzerodivisor(){
        require(valset==true,"set values for no1 and no2");
        require(no2!=0,"The second number should not be zero");
        _;
    }
}

contract base{
    uint i;
    function set(uint a) public {
        i=a;
    }
    function geti() public view returns(uint){
        return i;
    }
}

contract derived is base{
    function setd(uint a) public{
        super.set(a);
        i = a;
    }
}

