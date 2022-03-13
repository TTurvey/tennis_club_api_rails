# Tennis Club API - Tech Test  

## Table of Contents  
1. [Requirements](#requirements)
2. [Dependencies](#dependencies)
3. [API setup](#apisetup)
4. [URL Parameters](#urlparameters)
5. [Useful commands](#usefulcommands)
6. [Databases](#databases)
7. [Test Suites](#testsuites)
8. [Deployment](#testsuites)
9. [Requirements met](#requirementsmet)
10. [Design](#design)
11. [Future Development](#futuredevelopment)

&nbsp;

---
<a name="requirements"></a>  

## Requirements  
You are the president of the local Tennis Club.
Your responsibilities include managing its players and their rankings. You’ve been asked to prepare a backend API in your preferred programming language that consists of the following endpoints:

**1. An endpoint for registering a new player into the club**
  - a. The only required data for registration is the player’s first name and last name, nationality, and the date of birth.  
  - b. No two players of the same first name and last name can be added.  
  - c. Players must be at least 16 years old to be able to enter the club.  
  - d. Each newly registered player should start with the score of 1200 points for the purpose of the ranking.  

**2. An endpoint listing all players in the club**
  - a. It should be possible to list only players of particular nationality and/or rank name (see the bottom of the document) or all players.  
  - b. The list should contain the following information for every player:  
    - i. the current position in the whole ranking  
    - ii. first and last name  
    - iii. age  
    - iv. nationality  
    - v. rank name  
    - vi. points  
  - c. The players should be ordered by points (descending)  
    - i. The unranked players should also be ordered by points (descending) but should appear at the bottom of the list, below all other ranks

**3. An endpoint for registering a match that has been played**  
  - a. It should require providing the winner and the loser of the match  
  - b. The loser gives the winner 10% of his points from before the match (rounded down)  
    - i. For example, if Luca (1000 points) wins a match against Brendan (900 points), Luca should end up with 1090 points after the game and Brendan with 810  
    - ii. If Daniel (700 points) wins a match against James (1200 points), Daniel should end up with 820 points after the game and James with 1080  
  - c. The business logic behind calculating new player scores after a match should be unit-tested  

The code should be as readable and as well-organized as possible. Add any other information and/or extra validation for the above endpoints as you deem necessary.

<center>

| Rank              | Points                                    |
| :---:             | :---:                                     |
| Unranked          | (The player has played less than 3 games) |
| Bronze            | 0 – 2999                                  |
| Gold              | 5000 – 9999                               |
| Supersonic Legend | 10000 – no limit                          |
</center>

&nbsp;

<a name="dependencies"></a>

## Dependencies used:
---
Ruby version 3.0.0  
Rails version 6.1.4

&nbsp;

<a name="apisetup"></a>

## API Setup: 
---
Install dependencies within the Gemfile, `bundle install`.  
Start the server, `rails s`.  

&nbsp;

<a name="urlparameters"></a>

## Url parameters  
---
Index - List of all players ordered in descending position with unranked players at the bottom.  
http://localhost:5000/players

For a specific player, for example a player with id 1, visit:  
http://localhost:3000/players/1  

For a list of all matches entered visit:
http://localhost:3000/matches  

For a specific match, for example a match with id 1, visit:  
http://localhost:3000/matches/1  

For a specific players matches, for example a player with id 1, visit:  
http://localhost:3000/players/1/matches  

You can filter the players by nationality and or rank_name. Here are some examples.  
http://localhost:3000/players?rank_name=Bronze  
http://localhost:3000/players?nationality=British  
http://localhost:3000/players?nationality=British&rank_name=Bronze  

&nbsp;

<a name="usefulcommands"></a>

## Useful commands
---
 
Start the server with either `rails s` or `rails server`.  
Enter either `rails c` or `rails console` in the terminal  to open the irb environment.  
In irb you can enter the following commands:  
``` ruby
Player.create(first_name: '', last_name: '', nationality: '', date_of_birth: '')

Player.create(first_name: '', last_name: '', nationality: '', date_of_birth: '')

# At least two players have to have been created to create a match.
Match.create(winner_id: '', loser_id: '')

```  

&nbsp;

## Databases  
---
There are three databases; tennis_club_api2_development, tennis_club_api2_test and tennis_club_api2_production.

The following command will setup the development database.

rails db:drop db:create db:migrate



&nbsp;

## Test suites  
---
I have used RSpec to test the Player model.  
All RSpec tests can be run with `bundle exec rspec`.  

I have used the built-in testing framework that comes with the Rails library to test the controller `bin/rails test`.

&nbsp;

## Deployment  
---
Heroku...

&nbsp;

bundle install --redownload
rake db:create

Start the server up with `rails s` or `rails server`.  
Navigate to localhost:3000 in browser.  
localhost:3000/players for a list of all players.  

Enter `rails c` or `rails console` into the terminal to get irb up.  
In irb you can enter `Player.create(first_name: '', last_name: '', nationality: '', date_of_birth: '')`.  



psql
\c tennis_club_api2_development
\dt
SELECT * FROM players;
DELETE FROM players WHERE id=2;

rails generate model Players first_name:string last_name:string nationality:string date_of_birth:string 

rails generate model Matches winner:string loser:string


&nbsp;

<a name="requirementsmet"></a>

## Requirements met
---
- Required player creation params being first_name, last_name, nationality and date_of_birth. ✅  
- Unique player full names (first name + last name). ✅  
- Player creation age restriction (not younger than 16yrs old). ✅
- Players have initial points of 1200. ✅
- List only players with specific nationality and or rank_name (see url parameters section) or all players. ✅  
- List contains the required information for each player. ✅  
- List of players are sorted by points (current_position works the same) with unranked players at the bottom of the list. ✅  
- Creating a match requires entering the winner and loser (ids). ✅  
- The loser give 10% of points to the winner. ✅  
- Business logic for the players points exchange should be unit tested. ❌  

&nbsp;

## Design  
---
Reasons for why I decided to use Ruby on Rails:
- It allowed me to set up a default api project with one command.
- I was aware that Rails would create the MVC (Model, Controller, View) pattern for me.
- Model relationships can be implemented with a few lines of code.

Other design considerations:
- I have built this API with the aim of keeping the business logic in the models and the view rendering aspects in the controller so that the API adheres to the 'fat model, skinny controller' concept.
- I didn't see a need to create more classes, for example a winner class or a loser. Rails allowed me to reference the players as winner and loser in each match.

&nbsp;

<a name="futuredevelopment"></a>

## Future development
---
The API could be improved with the following things:
- Not all unit testing has been completed. Testing has only been done on a few areas of the code at the moment. Ideally all the controller and model methods would be tested for both the Player and Match classes.  
- Deleting a match that was played or maybe just entered in error would require player points to be rewinded. Any matches that they had played with others since the deleted match would also have to be updated with their 'would-have-been' points at the time. This represents a bit of a challenge that I will keep looking into.
- I didn't get time to deploy to Heroku but this would have been my next step so that I can check that a user can interact with the API as expected using curl commands.
