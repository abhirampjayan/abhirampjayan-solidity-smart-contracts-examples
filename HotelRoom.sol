// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract HotelRoom {
    enum Statuses {
        Vacant,
        Occupied
    }
    address payable public owener;
    Statuses public status;
    event Occupy(address _occupant, uint256 _value);

    modifier onlyWhileVacant() {
        require(status == Statuses.Vacant, "Currently occupied.");
        _;
    }

    modifier minConsts(uint256 _amount) {
        require(msg.value >= 2 ether, "Not Enough Ether Provieded.");
        _;
    }

    constructor() {
        owener = payable(msg.sender);
        status = Statuses.Vacant;
    }

    function book() public payable onlyWhileVacant minConsts(2 ether) {
        status = Statuses.Occupied;
        owener.transfer(msg.value);
        (bool sent, bytes memory data) = owener.call{value: msg.value}("");
        require(true);

        emit Occupy(msg.sender, msg.value);
    }
}
