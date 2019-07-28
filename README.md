![Inscrutable_game_logo](https://user-images.githubusercontent.com/47403119/62011684-c3a27680-b138-11e9-81c8-aad10280b7af.png)

## Installation

- Fork and clone this repository.

- Install gem dependencies `$ bundle install`

- Create database, load tables: `$ rake db:migrate`

- Run game:
    1. Open 'config/environment'
    2. Uncomment `play_game`
    3. Open Terminal, increase text size ~ 10 times ('Cmd' + '+'), enter full screen.
    4. While in `Inscrutable/` directory, enter `$ ruby config/environment.rb`

## Rules / Game Flow

- Player is initially given a sequence of numbers 1 - 9

- CPU scrambles the board using four randomized transformations.

- Player then has 4 moves to rearrange the pieces correctly.

## ActiveRecord // SQLite3

- Using activerecord, player stats recorded:
    * Wins
    * Losses
    * Win_percentage
    * Number of games played
    * Last time played
    * Last time played result
    * Quickest victory

- Using activerecord, general leaderboards across users recorded:
    * Quickest victory
    * Most games played
    * Most wins
    * Most losses
    * Best win percentage
    * Total games played across all users
    * Total wins
    * Total losses

A more in depth explanation of the game available here:
  - [insert Medium article]
