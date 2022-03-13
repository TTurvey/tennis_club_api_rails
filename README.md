# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


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


For a list of all players visit:
http://localhost:3000/players

For a specific player, for example a player with id 1, visit:
http://localhost:3000/players/1

For a list of all matches entered visit:
http://localhost:3000/matches

For a specific match, for example a match with id 1, visit:
http://localhost:3000/matches/1

For a specific players matches, for example a player with id 1 matches, visit:
http://localhost:3000/players/1/matches

You can filter the players by nationality and or rank_name.
http://localhost:3000/players?rank_name=Bronze
http://localhost:3000/players?nationality=British
http://localhost:3000/players?nationality=British&rank_name=Bronze



Fat models and skinny controllers.
The class models should be the ones to implement filtering based on data they receive from the controller.

