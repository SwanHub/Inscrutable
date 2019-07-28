![Inscrutable_game_logo](https://user-images.githubusercontent.com/47403119/62011684-c3a27680-b138-11e9-81c8-aad10280b7af.png)

## Installation

- fork and clone this repository.

- `$ bundle install`

- create database: `$ rake db:migrate`

- run game: `$ ruby config/environment.rb`

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
