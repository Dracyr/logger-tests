# Log-Store Logging

This folder contains a logging stack using [log-store](https://log-store.com/). It uses the docker syslog driver to forward directly from docker to log-store.

## Usage

To start the cluster and view the logs run the following.

```sh
docker compose up

# Open the log-store interface
open http://localhost:8181
```
