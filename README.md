# nrt-container

`./run.sh` starts cron in container exposing docker socket internally. Fetches source repository for jobs and executes.

`.env.sample` copy to `.env` to set environment variables.

`credentials.json` save service account credentials here.

### Source repository

Default: https://github.com/resource-watch/nrt-scripts.git

Each job in the source repository should be in it's own folder with `cron.time` and `start.sh` files, as follows.

```
Repository
|
|-Script 1 folder
| |-cron.time        # single line containing crontab frequency
| |-start.sh         # shell script to start job in new container
| |-.env             # this repo's .env file will be copied here
| |-credentials.json # this repo's credentials.json file will be copied here
| +-...
|
|-Script 2 folder
| +-...
|
+-...
```
