# Problem
We are creating a game called twenty-one in which the player tries to get their cards to value as close to 21 as possible without going over. If the player goes over 21, they automatically lose. The game consists of a dealer and a player.
### Explicit Requirements
- Start with normal 52-card deck
- Both participants are initially dealt 2 cards
- Participants have one card hidden from the other participants
#### Card values
- Numbers 2 through 10 are worth their face value
- Jack, Queen, and King are all worth 10
- Ace is worth 11 but becomes worth 1 if a player would have a value over 21
#### Player turn
- The player goes first
- On the player's turn they can decide to either 'hit' or 'stay'.
  - Hit means they get an additional card.
  - Stay means they lock in their current hand.
#### Dealer turn
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
- Hash to hold each players cards, ace count, and score

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

# Bonus Features
1. To avoid repeated calculation of hands, we should have a working total that adds the value of each card. To implement this, we could also have an ace tally so we know how many times we can deduct 10 from the score.

2. > We use the play_again? three times: after the player busts, after the dealer busts, or after both participants stay and compare cards. Why is the last call to play_again? a little different from the previous two?

    The method itself here does not change but in the previous instances we are skipping over the rest of the code in the loop.

# Adjusted Algorithm
- Setup deck and hands as specified in data structure
- Deal cards one at a time alternating beginning with the player to start the game, both players should then have 2 cards
- Show hands to the user
  - Show the dealer's first card and show all subsequent cards as unknown cards
  - Show all of the player's cards
- Allow player to hit or stay
- Computer should hit if below 17, otherwise stay
- After every card, add card value to hand total, if card is an ace, add 1 to ace tally.
- Check to see if hand total is over 21 if it is....
  - If an ace tally is positive, deduct 10 from total and 1 from ace tally, continue the game
  - If ace tally is not positive, display what player is over 21 and declare the other player the winner
