// SPDX-License-Identifier: MIT

module Voting {
    public struct Vote {
        receiver: address,
    }

    public struct VotingContract {
        isVoting: bool,
        votes: vector<SignerVote>, // Modified: Wrap Vote in SignerVote
    }

    public struct SignerVote {
        signer: signer,
        vote: Vote,
    }

    public struct AddVoteEvent {
        voter: address,
        receiver: address,
    }

    public struct RemoveVoteEvent {
        voter: address,
    }

    public struct StartVotingEvent {
        voter: address,
    }

    public struct StopVotingEvent {
        voter: address,
    }

    public fun startVoting(account: &signer) {
        let voting: VotingContract = Default::default();
        voting.isVoting = true;
        move_to(voting, account);
        Event::emit(StartVotingEvent { voter: signer::address_of(account) });
    }

    public fun stopVoting(account: &signer) {
        let voting: VotingContract = Default::default();
        voting.isVoting = false;
        move_to(voting, account);
        Event::emit(StopVotingEvent { voter: signer::address_of(account) });
    }

    public fun addVote(account: &signer, receiver: address) {
        let voting: VotingContract = Default::default();
        move_to(voting, account);

        let voter = signer::address_of(account);
        let vote = Vote { receiver };
        let signer_vote = SignerVote { signer: account, vote };
        
        // Modified: Push the SignerVote to the votes vector
        Vector::push_back(&mut voting.votes, signer_vote);

        Event::emit(AddVoteEvent { voter, receiver });
    }

    public fun removeVote(account: &signer) {
        let voting: VotingContract = Default::default();
        move_to(voting, account);

        // Modified: Pop the last element from the votes vector
        Vector::pop_back(&mut voting.votes);

        Event::emit(RemoveVoteEvent { voter: signer::address_of(account) });
    }

public fun getVotes(account: &signer, voterAddress: address): address {
    let voting: VotingContract;
    move_from(voting, account);

    if (!voting.isVoting) {
        return voterAddress;
    }

    let votes_len = voting.votes.len(); 

    // Access the last element of the votes vector
    let last_vote = voting.votes[votes_len - 1];

    // Return the receiver of the last vote
    return last_vote.receiver;
}

 
}
