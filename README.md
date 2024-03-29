# csc462: Distributed Systems Project
# Boat Data Store: SQL variant

## Contents:
- boats.sql (for now). To provide a sense of how the final schema will probably end up looking like.

- /swarm - Contains the front end cluster configs, scripts and documentation

- /web: (Under construction) web-based front end for testing and demonstration. Includes Express middleman server to route AJAX requests from client to either mongoDB (not included) or mySQL

- /mysql - Contains mysql cluster config files

- /mysql-docker - Contains mysql cluster config files using docker (deprecated)

## Upcoming:
- Distributed implementation of SQL database
- Other components as appropriate

## Running the front end page
- In `web/`, run `npm install`
- Navigate to `web/client/`, run `npm install` again.
- Create a file, `.env`, and set its contents as follows:
  - `PORT=3001`
- Head up one level to `web/`
- Run `npm start & (cd client && npm start)`

## Integrating the submodule
I've converted the web folder into a submodule. To update it, do the following:
- Navigate to the main folder of the repo.
- `git pull`, should delete the contents of the `web/` folder.
  - If `web/` folder is not empty, then run `rm -rf web/*`
- `git submodule update --init --recursive`
- In the future, to update your submodules, you can either `git pull` from the submodule folder (`web/` in this case), or just run `git pull && git submodule update --recursive` from the main folder.