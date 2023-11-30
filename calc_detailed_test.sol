// SPDX-License-Identifier: GPL-3.0
        
pragma solidity >=0.4.22 <0.9.0;

// This import is automatically injected by Remix
import "remix_tests.sol"; 

// This import is required to use custom transaction context
// Although it may fail compilation in 'Solidity Compiler' plugin
// But it will work fine in 'Solidity Unit Testing' plugin
// import "remix_accounts.sol";
import "hardhat/console.sol";
import "../mycontracts/calc4.sol";
import "../mycontracts/caseresources.sol";

bool constant isLoggingOn = true;
uint constant iterations = 25;

// File name has to end with '_test.sol', this file can contain more than one testSuite contracts
contract calcTestSuite {
    Calc calc = new Calc();

    function testAddNumbers() public{
        uint number1;
        uint number2;
        for(uint i;i<iterations;i++){
            number1 = uint(keccak256(abi.encodePacked(i,number2)))%255;
            number2 = uint(keccak256(abi.encodePacked(i,number1)))%255;
            calc.setOperands(int(number1),int(number2));
            try calc.addNumbers(){
                if ( calc.getResult() == int(number1+number2)){
                    Assert.ok(true,"SUCCESS");
                    if(isLoggingOn)console.log("PASSED(+) => %s + %s = %s",uint(number1),uint(number2),uint(calc.getResult()));
                    continue;
                }
                Assert.ok(false,"addition mismatch");
                if(isLoggingOn)console.log("FAILED(+) => %s + %s != %s",uint(number1),uint(number2),uint(calc.getResult()));
            }catch (bytes memory){
                Assert.ok(false,"Exception error");
                if(isLoggingOn)console.log("FAILED(+) => %s + %s failed with error: %s",uint(number1),uint(number2),"Exception error");
            }
        }
    }
    function testSubtractNumbers() public{
        uint number1;
        uint number2;
        for(uint i;i<iterations;i++){
            number1 = uint(keccak256(abi.encodePacked(i,number2)))%255;
            number2 = uint(keccak256(abi.encodePacked(i,number1)))%255;
            calc.setOperands(int(number1),int(number2));
            try calc.subtractNumbers() {
                if(uint(calc.getResult()) == uint(number1)-uint(number2)){
                    Assert.ok(true,"SUCCESS");
                    if(isLoggingOn)console.log("PASSED(+) => %s - %s = %s",uint(number1),uint(number2),uint(calc.getResult()));
                    continue;
                }
                Assert.ok(false,"subtraction mismatch");
                if(isLoggingOn)console.log("FAILED(+) => %s - %s != %s",uint(number1),uint(number2),uint(calc.getResult()));
            }catch Error(string memory error) {
                if ( number2 > number1 ){
                    if ( keccak256(abi.encodePacked(error)) == keccak256(abi.encodePacked(SUBTRACTION_ERROR))){
                        Assert.ok(true,error);
                        if(isLoggingOn)console.log("PASSED(-) => %s - %s skipped: %s",uint(number1),uint(number2),error);
                        continue;
                    }
                    Assert.ok(false,error);
                    if(isLoggingOn)console.log("FAILED(-) => %s - %s failed with error: %s",uint(number1),uint(number2),error);
                    continue;
                }
                Assert.ok(false,error);
                if(isLoggingOn)console.log("FAILED(+) => %s - %s failed with error: %s",uint(number1),uint(number2),error);
            }catch (bytes memory){
                if ( number2 > number1 ){
                    Assert.ok(false,"Exception error");
                    if(isLoggingOn)console.log("FAILED(-) => %s - %s failed with error: %s",uint(number1),uint(number2),"Exception error");
                    continue;
                }
                Assert.ok(false,"Exception error");
                if(isLoggingOn)console.log("FAILED(+) => %s - %s failed with error: %s",uint(number1),uint(number2),"Exception error");
            }
        }
    }
    function testMultiplyNumbers() public{
        uint number1;
        uint number2;
        for(uint i;i<iterations;i++){
            number1 = uint(keccak256(abi.encodePacked(i,number2)))%255;
            number2 = uint(keccak256(abi.encodePacked(i,number1)))%255;
            calc.setOperands(int(number1),int(number2));
            try calc.multiplyNumbers(){
                if ( uint(calc.getResult()) == number1*number2){
                    Assert.ok(true,"SUCCESS");
                    if(isLoggingOn)console.log("PASSED(+) => %s * %s = %s",uint(number1),uint(number2),uint(calc.getResult()));
                    continue;
                }

                Assert.ok(false,"multiplication mismatch");
                if(isLoggingOn)console.log("FAILED(+) => %s * %s != %s",uint(number1),uint(number2),uint(calc.getResult()));
            }catch (bytes memory){
                Assert.ok(false,"Exception error");
                if(isLoggingOn)console.log("FAILED(+) => %s * %s failed with error: %s",uint(number1),uint(number2),"Exception error");
            }
        }
    }
    function testDivideNumbers() public{
        uint number1;
        uint number2;
        for(uint i;i<iterations;i++){
            number1 = uint(keccak256(abi.encodePacked(i,number2)))%255;
            number2 = uint(keccak256(abi.encodePacked(i,number1)))%255;
            if( i%3 == 0 ) number2 = 0;
            calc.setOperands(int(number1),int(number2));
            try calc.divideNumbers() {
                if(uint(calc.getResult()) == number1/number2){
                    Assert.ok(true,"SUCCESS");
                    if(isLoggingOn)console.log("PASSED(+) => %s / %s = %s",uint(number1),uint(number2),uint(calc.getResult()));
                    continue;
                }
                Assert.ok(false,"division mismatch");
                if(isLoggingOn)console.log("FAILED(+) => %s / %s != %s",uint(number1),uint(number2),uint(calc.getResult()));
            }catch Error(string memory error) {
                if(number2 == 0){
                    if ( keccak256(abi.encodePacked(error)) == keccak256(abi.encodePacked(DIVIDE_ERROR))){
                        Assert.ok(true,error);
                        if(isLoggingOn)console.log("PASSED(-) => %s / %s skipped: %s",uint(number1),uint(number2),error);
                        continue;
                    }
                    Assert.ok(false,error);
                    if(isLoggingOn)console.log("FAILED(-) => %s / %s failed with error: %s",uint(number1),uint(number2),error);
                    continue;
                }
                Assert.ok(false,error);
                if(isLoggingOn)console.log("FAILED(+) => %s / %s failed with error: %s",uint(number1),uint(number2),error);
            }catch (bytes memory){
                if(number2 == 0){
                    Assert.ok(false,"Exception error");
                    if(isLoggingOn)console.log("FAILED(-) => %s / %s failed with error: %s",uint(number1),uint(number2),"Exception error");
                    continue;
                }
                Assert.ok(false,"Exception error");
                if(isLoggingOn)console.log("FAILED(+) => %s / %s failed with error: %s",uint(number1),uint(number2),"Exception error");
            }
        }
    }
    function testModulusOfNumbers() public{
        uint number1;
        uint number2;
        for(uint i;i<iterations;i++){
            number1 = uint(keccak256(abi.encodePacked(i,number2)))%255;
            number2 = uint(keccak256(abi.encodePacked(i,number1)))%255;
            if( i%3 == 0 ) number2 = 0;
            calc.setOperands(int(number1),int(number2));
            try calc.modulusOfNumbers() {
                if(uint(calc.getResult()) == number1%number2){
                    Assert.ok(true,"SUCCESS");
                    if(isLoggingOn)console.log("PASSED(+) => %s % %s = %s",uint(number1),uint(number2),uint(calc.getResult()));
                    continue;
                }
                Assert.ok(false,"modulus mismatch");
                if(isLoggingOn)console.log("FAILED(+) => %s % %s != %s",uint(number1),uint(number2),uint(calc.getResult()));
            }catch Error(string memory error) {
                if ( number2 == 0 ) {
                    if ( keccak256(abi.encodePacked(error)) == keccak256(abi.encodePacked(MODULUS_ERROR))){
                        Assert.ok(true,error);
                        if(isLoggingOn)console.log("PASSED(-) => %s % %s skipped: %s",uint(number1),uint(number2),error);
                        continue;
                    }
                    Assert.ok(false,error);
                    if(isLoggingOn)console.log("FAILED(-) => %s % %s failed with error: %s",uint(number1),uint(number2),error);
                    continue;
                }
                Assert.ok(false,error);
                if(isLoggingOn)console.log("FAILED(+) => %s % %s failed with error: %s",uint(number1),uint(number2),error);
            }catch (bytes memory){
                if ( number2 == 0 ) {
                    Assert.ok(false,"Exception error");
                    if(isLoggingOn)console.log("FAILED(-) => %s % %s failed with error: %s",uint(number1),uint(number2),"Exception error");
                    continue;
                }
                Assert.ok(false,"Exception error");
                if(isLoggingOn)console.log("FAILED(+) => %s % %s failed with error: %s",uint(number1),uint(number2),"Exception error");
            }
        }
    }
    function testSquareOfNumber() public{
        for(int i; i<int(iterations) ; i++){
            try calc.squareOfNumber(i) returns(int result){
                if ( result == i*i) {
                    Assert.ok(true,"SUCCESS");
                    if(isLoggingOn)console.log("PASSED(+) => square(%s) = %s",uint(i),uint(result));
                    continue;
                }
                Assert.ok(false,"square mismatch");
                if(isLoggingOn)console.log("FAILED(+) => square(%s) != %s",uint(i),uint(result));
            }catch Error(string memory error) {
                if ( i > 10 ) {
                    if ( keccak256(abi.encodePacked(error)) == keccak256(abi.encodePacked(SQUARE_ERROR))){
                        Assert.ok(true,error);
                        if(isLoggingOn)console.log("PASSED(-) => square(%s) skipped: %s",uint(i),error);
                        continue;
                    }
                    Assert.ok(false,error);
                    if(isLoggingOn)console.log("FAILED(-) => square(%s) failed with error: %s",uint(i),error);
                    continue;
                }
                Assert.ok(false,error);
                if(isLoggingOn)console.log("FAILED(+) => square(%s) failed with error: %s",uint(i),error);
            }catch (bytes memory){
                if ( i > 10 ) {
                    Assert.ok(false,"Exception error");
                    if(isLoggingOn)console.log("FAILED(-) => square(%s) failed with error: %s",uint(i),"Exception error");
                    continue;
                }
                Assert.ok(false,"Exception error");
                if(isLoggingOn)console.log("FAILED(+) => square(%s) failed with error: %s",uint(i),"Exception error");
            }
        }
    }
    function testFactorialOfNumber() public{
        int[7] memory numbers = [int(0),int(1),int(2),int(3),int(5),int(6),int(100)];
        int[7] memory factorial = [int(0),int(1),int(2),int(6),int(120),int(720),int(0)];
        for(uint i; i<numbers.length ; i++){
            try calc.factorialOfNumber(numbers[i]) returns (int result){
                if ( result == factorial[i]) {
                    Assert.ok(true,"SUCCESS");
                    if(isLoggingOn)console.log("PASSED(+) => factorial(%s) = %s",uint(numbers[i]),uint(result));
                    continue;
                }
                Assert.ok(false,"factorial mismatch");
                if(isLoggingOn)console.log("FAILED(+) => factorial(%s) != %s",uint(numbers[i]),uint(result));
           }catch Error(string memory error) {
                if ( numbers[i]==0 || numbers[i] > 10 ) {
                    if ( keccak256(abi.encodePacked(error)) == keccak256(abi.encodePacked(FACTORIAL_ERROR))){
                        Assert.ok(true,error);
                        if(isLoggingOn)console.log("PASSED(-) => factorial(%s) skipped: %s",uint(numbers[i]),error);
                        continue;
                    }
                    Assert.ok(false,error);
                    if(isLoggingOn)console.log("FAILED(-) => factorial(%s) with error: %s",uint(numbers[i]),error);
                    continue;
                }
                Assert.ok(false,error);
                if(isLoggingOn)console.log("FAILED(+) => factorial(%s) with error: %s",uint(numbers[i]),error);
            }catch (bytes memory){
                if ( numbers[i]==0 || numbers[i] > 10 ) {
                    Assert.ok(false,"Exception error");
                    if(isLoggingOn)console.log("FAILED(-) => factorial(%s) failed with error: %s",uint(numbers[i]),"Exception error");
                    continue;
                }
                Assert.ok(false,"Exception error");
                if(isLoggingOn)console.log("FAILED(+) => factorial(%s) failed with error: %s",uint(numbers[i]),"Exception error");
            }
        }
    }
}