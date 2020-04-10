# A Rails API for tracking personal activity

Uses [pete-client](https://github.com/kutrumbo/pete-client) as the client

## Getting started

Requires Ruby 2.7.1 and Postgres 12.2

Create a `.env` file using the following template:

```
STRAVA_CLIENT_ID=<CLIENT_ID>
STRAVA_CLIENT_SECRET=<CLIENT_SECRET>

```

Prepare the DB and start the application:

```
# Install dependencies
bundle install

# Setup DB
rake db:setup

# Start server
rails s
```
