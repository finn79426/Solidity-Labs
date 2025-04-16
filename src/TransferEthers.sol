// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract Sender {

    function transfer(address to) public {
        payable(to).transfer(address(this).balance);
    }

    function send(address to) public {
        payable(to).send(address(this).balance);
    }

    function call(address to) public {
        payable(to).call{value: address(this).balance}("");
    }

    function callWithSuc(address to) public {
        (bool suc, ) = payable(to).call{value: address(this).balance}("");
    }

    function callWithData(address to) public {
        (bool suc, bytes memory data) = payable(to).call{value: address(this).balance}("");
    }

    function yulWithoutReturnData(address to) public {
        assembly {
            pop(
                call(
                    gas(),
                    to,
                    selfbalance(),
                    0,
                    0,
                    0,   
                    0    
                )
            )
        }
    }
}

