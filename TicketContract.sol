// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract TicketPlatform {
    address public organizer;
    address public platform;
    uint public ticketPrice;
    mapping(address => uint) public ticketBalances;

    constructor(uint _ticketPrice, address _platform) {
        organizer = msg.sender;
        platform = _platform;
        ticketPrice = _ticketPrice;
    }

    function buyTickets() public payable {
        require(msg.value >= ticketPrice, "Not enough funds to buy a ticket");
        ticketBalances[msg.sender] += 1;

        uint organizerShare = (ticketPrice * 97) / 100;
        uint platformShare = ticketPrice - organizerShare;
        payable(organizer).transfer(organizerShare);
        payable(platform).transfer(platformShare);
    }
}