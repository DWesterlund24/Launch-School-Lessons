# Problem
We are creating a game called twenty-one in which the player tries to get their cards to value as close to 21 as possible without going over. If the player goes over 21, they auromatically lose. The game consists of a dealer and a player.
### Explicit Requirements
- Start with normal 52-card deck
- Both participants are initially dealt 2 cards
- Participants have one card idden from the other participants
#### Card values
- Numbers 2 through 10 are worth their face value
- Jack, Queen, and King are all worth 10
- Ace is worth 11 but becomes worth 1 if a player would have a value over 21
#### Player turn
- The player goes first
- On the player's turn they can decide to either 'hit' or 'stay'.
  - Hit means they get an addition card.
  - Stay means they lock in their current hand.
#### Dealer turn
- When the player stays, it's the dealer's turn
- The dealer should hit until their total is at least 17, at which point they should stay.
#### Comparing cards
- When both players stay and neither have gone over 21, the higher value wins

# High Level Implementation
1. Initialize deck
2. Deal cards to player and dealer
3. Player turn: hit or stay
  - repeat until bust or "stay"
4. If player bust, dealer wins.
5. Dealer turn: hit or stay
  - repeat until total >= 17
6. If dealer bust, player wins.
7. Compare cards and declare winner.

# Data Structure
- Hash to hold card values
- We can remove pairs from the hash as they are dealt
- Hands will be arrays holding the keys to the hash

# Algorithm
- Setup deck and hands as specified in data structure
- Deal cards one at a time alternating beginning with the player to start the game, both players should then have 2 cards
- Show hands to the user
  - Show the dealers first card and show all subsequent cards as unknown cards
  - Show all of the players cards
- Allow player to hit or stay
- Computer should hit if below 17, otherwise stay
- After every card check to see if hand is over 21 if it is....
  - If an ace is present, convert the first ace to a 1 and continue the game
  - If there are no aces, display what player is over 21 and declare the other player the winner

# Non Required Additions
- We can ask the player if they'd like to continue playing after each round
- Instead of reshuffling the deck everytime, we could wait until we've gone through the whole deck to reshuffle by adding a discard pile. This would of course only come into play if the player decides to keep playing.
