// SPDX-License-Identifier: MIT

pragma solidity ^0.8 ; // Using Solidity 8 

import "./caseresources.sol";

contract Calc{

    int private _firstOperand;
    int private _secondOperand;
    int private _result;
    
    function setOperands (int firstOperand, int secondOperand) public {
        _firstOperand = firstOperand;
        _secondOperand = secondOperand;
    }

    function multiplyNumbers() public {
        _result = _firstOperand * _secondOperand;
    }

    function divideNumbers() public {
        require(_secondOperand!=0,DIVIDE_ERROR);
        _result = _firstOperand / _secondOperand;
    }

    function addNumbers() public {
        _result = _firstOperand + _secondOperand;
    }

    function subtractNumbers() public {
        require(_firstOperand>=_secondOperand,SUBTRACTION_ERROR);
        _result = _firstOperand - _secondOperand;
    }

    function modulusOfNumbers() public {
        require(_secondOperand!=0,MODULUS_ERROR);
        _result = _firstOperand % _secondOperand;
    }

    function getResult() public view returns (int) {
        return _result;
    }

    function squareOfNumber(int number) public pure returns (int) {
        require(number<=10,SQUARE_ERROR);
        return number*number;
    }

    function factorialOfNumber(int number) public pure returns(int){
        require(number>0 && number<=10, FACTORIAL_ERROR);
        if (number == 1) {
            return 1;
        }
        return number * factorialOfNumber(number-1);
    }
}
