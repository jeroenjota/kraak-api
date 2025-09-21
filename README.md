# kraakapi
## API for Laurierboom Kraaskcore


This is a simple API for the Laurierboom kraaskcore. It is built with Node.js and Express. It uses a JSON file as a database to store the scores of the tournament players.
The API has the following endpoints:  
- `GET /ping`: Returns a simple "pong" message to check if the API is running.
- `PUT /tournooien/:id`: Updates the details of a specific tournament.
- `GET /scores`: Returns the scores of all players.  
- `GET /scores/:name`: Returns the score of a specific player.  
- `GET /tournooien`: Returns the list of tournooien.  
- `GET /tournooien/:id`: Returns the details of a specific tournament. 
- `GET /tournamentID`: Returns the tournament ID from tournament date. 
- `POST /tournooien`: Adds a new tournament.  
- `PUT /tournooien/:date`: Updates the details of a specific tournament.  
- `DELETE /tournooien/:id`: Deletes a specific tournament.  
- `POST /spelers`: Add player to database.
- `GET /spelers`: Get all players from database.
- `GET /ranking`: Returns the current rankings of players based on their scores.
- `POST /upload`: Uploads a PDF file.
- `GET /pdf-exists/:filename`: Checks if a specific PDF file exists.

The API also has a function to calculate the scores of the players based on the results of the tournooien. The scores are calculated based on the following rules:  
- The first place team gets 4 points.  
- The second place team gets 3 points.  
- The third place team gets 2 points.  
- All other teams get 1 point for participation.  
- If a player is part of multiple teams in a tournament, they get the points for each team they are part of.  
The API is designed to be simple and easy to use. It can be easily extended to add more features or change the scoring rules. 

