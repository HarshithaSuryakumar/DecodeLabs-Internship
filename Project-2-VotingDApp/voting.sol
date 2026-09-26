// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Voting {

    // Contract owner
    address public owner;

    // Candidate structure
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    // Candidate ID => Candidate
    mapping(uint => Candidate) public candidates;

    // Wallet address => Has voted?
    mapping(address => bool) public hasVoted;

    // Total candidates
    uint public candidatesCount;

    // Event
    event Voted(address indexed voter, uint indexed candidateId);

    // Constructor
    constructor() {
        owner = msg.sender;
    }

    // Modifier
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    // Add candidate
    function addCandidate(string memory _name) public onlyOwner {
        candidatesCount++;

        candidates[candidatesCount] = Candidate({
            id: candidatesCount,
            name: _name,
            voteCount: 0
        });
    }

    // Vote
    function vote(uint _candidateId) public {
        require(!hasVoted[msg.sender], "You have already voted");
        require(
            _candidateId > 0 && _candidateId <= candidatesCount,
            "Invalid candidate"
        );

        hasVoted[msg.sender] = true;
        candidates[_candidateId].voteCount++;

        emit Voted(msg.sender, _candidateId);
    }

    // Get candidate details
    function getCandidate(uint _candidateId)
        public
        view
        returns (
            uint,
            string memory,
            uint
        )
    {
        Candidate memory c = candidates[_candidateId];

        return (
            c.id,
            c.name,
            c.voteCount
        );
    }

    // Get winner
    function getWinner()
        public
        view
        returns (
            string memory,
            uint
        )
    {
        uint highestVotes = 0;
        string memory winnerName = "";

        for (uint i = 1; i <= candidatesCount; i++) {
            if (candidates[i].voteCount > highestVotes) {
                highestVotes = candidates[i].voteCount;
                winnerName = candidates[i].name;
            }
        }

        return (
            winnerName,
            highestVotes
        );
    }
}