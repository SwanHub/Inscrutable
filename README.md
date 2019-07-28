


## Description

The intention of Inscrutable is to usher in a host of games created by students, instructors and alumni at Flatiron School. The hope is one day these games can make it to the app store and generate money for student scholarships. 

## Installation 

- gem `tty-prompt`
- gem `paint`

## Rules / Game Flow

- player is initially given a sequence of numbers 1 - 9 

- cpu scrambles the board using a random selection of the four transformations available to the user.
    (this ensures that the user can win.)
    
- The player then has 4 moves to rearrange the pieces correctly.

## ActiveRecord

- using activerecord, player stats recorded: 
    * wins
    * losses
    * win_percentage
    * number of games played
    * last time played 
    * last time played result
    * quickest victory

- using activerecord, general leaderboards across users recorded:
    * Fastest victory
    * Most games played 
    * Most wins 
    * Most losses
    * Best win percentage
    * Total games played across all users
    * Total wins
    * Total losses

A more in depth explanation of the game available here:
  - [insert Medium article]
