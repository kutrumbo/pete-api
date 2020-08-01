# A Rails API for tracking personal activity

Uses [pete-client](https://github.com/kutrumbo/pete-client) as the client

## Getting started

Create a `.env` file using the following template:

```
STRAVA_CLIENT_ID=<CLIENT_ID>
STRAVA_CLIENT_SECRET=<CLIENT_SECRET>
POSTGRES_USER=<POSTGRES_USER>
POSTGRES_DB=<POSTGRES_DB>
POSTGRES_PASSWORD=<POSTGRES_PASSWORD>
```

The application is setup to be run using, so only requirement is to have `docker` and `docker-compose` installed:

```
docker-compose up -d

# for initial setup and migrations
docker-compose exec app bundle exec rake db:setup db:migrate
```
