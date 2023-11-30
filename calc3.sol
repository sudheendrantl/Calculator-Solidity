// SPDX-License-Identifier: MIT

pragma solidity ^0.8 ; // Using Solidity 8 

contract Second{

    int public no1;
    int public no2;
    int public ans;
    
    function set (int x, int y) public {
        no1 = x;
        no2 = y;
    }

    function mul() public {
        ans = no1 * no2;
    }

    function div() public checkifnonzerodivisor {
        ans = no1 / no2;
    }

    function add() public {
        ans = no1 + no2;
    }

    function sub() public {
        require(no1>=no2,"The second nubmer has to be smaller");
        ans = no1 - no2;
    }

    function mod() public checkifnonzerodivisor {
        ans = no1 % no2;
    }

    function square(int x) public pure returns (int) {
        return x*x;
    }

    function factorial(int n) public pure returns(int){
        require(n>0, "Number cannot be 0");
        require(n<=20, "Number <=20 only supported");
        if (n == 1) {
            return 1;
        }
        return n * factorial(n-1);
    }

    function pow(uint a, uint b) public pure returns(uint){
        require(a<=10 || b<=5, "too large numbers!");
        return uint(a) ** uint(b);
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

    modifier checkifeven(int a){
        require(a%2==0,"Only Even Numbers will be squared...");
        _;
    }

    modifier checkifnonzerodivisor(){
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
        //super.set(a);
        i = a;
    }
}

