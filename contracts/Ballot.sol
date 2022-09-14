pragma solidity >=0.7.0 <0.9.0;

contract Ballot {

  struct Voter {
    uint vote;
    bool voted;
  }

  struct Candidate {
    bytes32 name;
    uint voteCount;
  }

  address public organiser;

  mapping(address => Voter) public voters;

  Candidate[] public candidates;

  constructor(bytes32[] memory candidatesNames) {
    organiser = msg.sender;

    // Constructs candidates
    for (uint i = 0; i < candidatesNames.length; i++) {
      candidates.push(Candidate({
        name: candidatesNames[i],
        voteCount: 0
      }));
    }
  }

  function checkRightToVote(Voter memory voter) external returns(bool) {
    return !voter.voted;
  }

  function vote(uint choice) external {
    Voter storage voter = voters[msg.sender];
    bool hasRightToVote = this.checkRightToVote(voter);

    if (hasRightToVote) {
      candidates[choice].voteCount += 1;
      voter.vote = choice;
    }
  }

  function getWinnerId() public view returns(uint winningCandidateId_) {
    uint winningVoteCount = 0;
    for (uint p = 0; p < candidates.length; p++) {
      if (candidates[p].voteCount > winningVoteCount) {
        winningVoteCount = candidates[p].voteCount;
        winningCandidateId_ = p;
      }
    }
  }

  function getWinner() external view returns(bytes32 winningCandidate_) {
    winningCandidate_ = candidates[getWinnerId()].name;
  }

}