# SuiVotesContract Move Module

## Overview

This Move module implements the Instant Runoff Voting (IRV) algorithm for a voting system. The module provides structures and functions for managing proposals, voters, and conducting IRV-based elections.

## Contents

- [Voting Module](#voting-module)
  - [Proposal Struct](#proposal-struct)
  - [IRVResult Struct](#irvresult-struct)
  - [Voting Struct](#voting-struct)
  - [run_irv Function](#run_irv-function)

## Voting Module

The `Voting` module contains structures and functions related to the voting system.

### Proposal Struct

The `Proposal` struct represents a proposal in the voting system and includes an `id` and a `name` (vector of bytes).

### IRVResult Struct

The `IRVResult` struct holds the result of an IRV election, including the winner and the rounds of the election.

### Voting Struct

The `Voting` struct manages the state of the voting system, including the list of proposals, voters, and votes.

### run_irv Function

The `run_irv` function conducts an Instant Runoff Voting election using the provided voting data. It iteratively eliminates proposals with the fewest votes until a winner is determined.

## Usage

To use this Move module, follow these steps:

1. Deploy the Move module to your blockchain.
2. Create instances of the `Voting` struct for your specific election.
3. Call the `run_irv` function to conduct the IRV election and obtain the result.

Example code snippet:

```move
// Instantiate the Voting struct with your proposals, voters, and votes
public 0x1::Voting::Voting<Proposal, AccountAddress> myElection = 0x1::Voting::Voting<Proposal, AccountAddress> {
  proposals: /* your vector of Proposal */,
  voters: /* your set of AccountAddress */,
  votes: /* your vector of votes */,
};

// Run the IRV election
let result = 0x1::Voting::run_irv(&mut myElection);

// Access the result, including the winner and rounds
let winner = result.winner;
let rounds = result.rounds;
