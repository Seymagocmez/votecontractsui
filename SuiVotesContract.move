module SuiVotesContract {

  // Definition of the Voting module
  module Voting {

    // Definition of the Proposal struct
    struct Proposal {
      id: u64,
      name: vector<u8>,
    }

    // Definition of the IRVResult struct
    struct IRVResult<T> {
      winner: T,
      rounds: vector<map<T, u64>>,
    }

    // Definition of the Voting struct
    struct Voting<T, AccountAddress> {
      proposals: vector<T>,
      voters: set<AccountAddress>,
      votes: vector<map<AccountAddress, T>>,
    }

    // Function to run the IRV algorithm
    public fun run_irv<T>(voting: &mut Voting<T, AccountAddress>): IRVResult<T> {
      let mut remaining_proposals: vector<T> = Vector::empty<T>();
      Vector::push_back_all(&mut remaining_proposals, &voting.proposals);

      let mut rounds: vector<map<T, u64>> = Vector::empty<map<T, u64>>();

      // Continue the process until there's only one proposal remaining
      while Vector::size(&remaining_proposals) > 1 {
        // Count votes for each remaining proposal
        let mut votes_count: map<T, u64> = Map::empty<T, u64>();

        // Iterate through voters
        for voter in Set::iter(&voting.voters) {
          // Get the voter's votes
          let voter_votes = Vector::pop(&voting.votes, voter);

          // If the voter has made a choice
          if Vector::size(&voter_votes) > 0 {
            // Count the first choice
            let first_choice = Vector::pop(&voter_votes);
            Map::insert(&mut votes_count, first_choice, Map::get(&votes_count, first_choice, 0) + 1);
          }
        }

        // Find the proposal with the minimum votes
        let (eliminated_proposal, min_votes) = Map::min(votes_count);

        // Record the votes for this round
        Vector::push_back(&mut rounds, votes_count);

        // Remove the proposal with the minimum votes
        Vector::remove(&mut remaining_proposals, eliminated_proposal);
      }

      // Get the winner (the last remaining proposal)
      let winner = Vector::pop(&remaining_proposals);

      // Record the votes for the final round
      Vector::push_back(&mut rounds, map<T, u64>(winner => u64::max_value()));

      return IRVResult {
        winner: winner,
        rounds: rounds,
      };
    }
  }
}
