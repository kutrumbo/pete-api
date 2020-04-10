# pete-api

An API to track personal activity

### Setup

Requires Ruby 2.7.1 and Postgres 12.2

To setup:

```
rake db:setup
```

And create a `.env` file using the following template:

```
STRAVA_CLIENT_ID=<CLIENT_ID>
STRAVA_CLIENT_SECRET=<CLIENT_SECRET>
```

To run:

```
rails s
```
