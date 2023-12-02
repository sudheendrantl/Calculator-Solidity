// SPDX-License-Identifier: GPL-3.0
        
pragma solidity >=0.4.22 <0.9.0;

// This import is automatically injected by Remix
import "remix_tests.sol"; 

// This import is required to use custom transaction context
// Although it may fail compilation in 'Solidity Compiler' plugin
// But it will work fine in 'Solidity Unit Testing' plugin
// import "remix_accounts.sol";
import "../mycontracts/calc.sol";

uint8 constant ITERATIONS = 25;

// File name has to end with '_test.sol', this file can contain more than one testSuite contracts
contract calcTestSuite {
    uint number1;
    uint number2;
    Calc calc = new Calc();
    function testAddNumbersFunction() public{
        for(uint i;i<ITERATIONS;i++){
            number1 = uint(keccak256(abi.encodePacked(i,number2)))%255;
            number2 = uint(keccak256(abi.encodePacked(i,number1)))%255;
            try calc.setOperands(int(number1),int(number2)){
                try calc.addNumbers(){
                    if ( calc.getResult() == int(number1+number2) ) {
                        Assert.ok(true,"");
                        continue;
                    }
                }catch{
                }
            }catch{
            }
            Assert.ok(false,"");
        }
    }
    function testSubtractNumbersFunction() public{
        for(uint i;i<ITERATIONS;i++){
            number1 = uint8(uint(keccak256(abi.encodePacked(i,number2)))%255);
            number2 = uint8(uint(keccak256(abi.encodePacked(i,number1)))%255);
            try calc.setOperands(int(number1),int(number2)){
                try calc.subtractNumbers(){
                    if ( uint(calc.getResult()) == number1-number2 ) {
                        Assert.ok(true,"");
                        continue;
                    }
                }catch Error(string memory) {
                    Assert.ok(true,"");
                    continue;
                }catch{
                }
            }catch{
            }
            Assert.ok(false,"");
        }
    }
    function testMultiplyNumbersFunction() public{
        for(uint i;i<ITERATIONS;i++){
            number1 = uint8(uint(keccak256(abi.encodePacked(i,number2)))%255);
            number2 = uint8(uint(keccak256(abi.encodePacked(i,number1)))%255);
            try calc.setOperands(int(number1),int(number2)){
                try calc.multiplyNumbers(){
                    if ( uint(calc.getResult()) == number1*number2 ){
                        Assert.ok(true,"");
                        continue;
                    }
                }catch{
                }
            }catch{
            }
            Assert.ok(false,"");
        }
    }
    function testDivideNumbersFunction() public{
        for(uint i;i<ITERATIONS;i++){
            number1 = uint8(uint(keccak256(abi.encodePacked(i,number2)))%255);
            number2 = uint8(uint(keccak256(abi.encodePacked(i,number1)))%255);
            if( i%3 == 0 ) number2 = 0;
            try calc.setOperands(int(number1),int(number2)){
                try calc.divideNumbers() {
                    if ( uint(calc.getResult()) == number1/number2 ){
                        Assert.ok(true,"");
                        continue;
                    }
                }catch Error(string memory) {
                    Assert.ok(true,"");
                    continue;
                }catch{
                }
            }catch{
            }
            Assert.ok(false,"");
        }
    }
    function testModulusOfNumbersFunction() public{
        for(uint i;i<ITERATIONS;i++){
            number1 = uint8(uint(keccak256(abi.encodePacked(i,number2)))%255);
            number2 = uint8(uint(keccak256(abi.encodePacked(i,number1)))%255);
            if( i%3 == 0 ) number2 = 0;
            try calc.setOperands(int(number1),int(number2)) {
                try calc.modulusOfNumbers() {
                    if (uint(calc.getResult()) == number1%number2){
                        Assert.ok(true,"");
                        continue;
                    }
                }catch Error(string memory) {
                    Assert.ok(true,"");
                    continue;
                }catch{
                }
            }catch{
            }
            Assert.ok(false,"");
        }
    }
    function testSquareOfNumberFunction() public{
        for(int8 i; i<int8(ITERATIONS); i++){
            try calc.squareOfNumber(int(i)) returns(int result){
                if ( result == int(i*i) ) {
                    Assert.ok(true,"");
                    continue;
                }
            }catch Error(string memory) {
                Assert.ok(true,"");
                continue;
            }catch{
            }
            Assert.ok(false,"");
        }
    }
    function testFactorialOfNumberFunction() public{
        int[7] memory numbers = [int(0),int(1),int(2),int(3),int(5),int(6),int(100)];
        int[7] memory factorial = [int(0),int(1),int(2),int(6),int(120),int(720),int(0)];
        for(uint i; i<numbers.length ; i++){
            try calc.factorialOfNumber(numbers[i]) returns (int result){
                if ( result == factorial[i]) {
                    Assert.ok(true,"");
                    continue;
                }
            }catch Error(string memory) {
                Assert.ok(true,"");
                continue;
            }catch{
            }
            Assert.ok(false,"");
        }
    }
}