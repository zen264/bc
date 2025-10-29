// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
contract Ballot {
struct Voter {
uint weight; // weight is accumulated by delegation
bool voted; // if true, that person already voted
address delegate; // person delegated to
uint vote; // index of the voted proposal
}
struct Proposal {
bytes32 name; // short name (up to 32 bytes)
uint voteCount; // number of accumulated votes
}
address public chairperson;
mapping(address => Voter) public voters
Proposal[] public proposals;




function delegate(address to) external {
Voter storage sender = voters[msg.sender];
require(sender.weight != 0, "You have no right to vote");
require(!sender.voted, "You already voted.");
require(to != msg.sender, "Self-delegation is disallowed.");
while (voters[to].delegate != address(0)) {
to = voters[to].delegate;
require(to != msg.sender, "Found loop in delegation.");
}
