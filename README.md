# Voting Module

This Move module implements a basic voting system with the following features:

- Starting and stopping voting sessions.
- Adding votes to the system.
- Removing the last vote from the system.
- Retrieving the receiver of the last vote.

## Smart Contracts

### Vote Struct
- `Vote`: Represents a vote with a designated receiver.

### VotingContract Struct
- `VotingContract`: Manages the voting process and holds a vector of `SignerVote`.

### SignerVote Struct
- `SignerVote`: Combines a signer with a `Vote`, representing a vote cast by a signer.

## Events

- `AddVoteEvent`: Triggered when a new vote is added.
- `RemoveVoteEvent`: Triggered when the last vote is removed.
- `StartVotingEvent`: Triggered when a voting session is started.
- `StopVotingEvent`: Triggered when a voting session is stopped.

## Public Functions

- `startVoting(account: &signer)`: Starts a new voting session.
- `stopVoting(account: &signer)`: Stops the current voting session.
- `addVote(account: &signer, receiver: address)`: Adds a new vote to the system.
- `removeVote(account: &signer)`: Removes the last vote from the system.
- `getVotes(account: &signer, voterAddress: address): address`: Retrieves the receiver of the last vote.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
