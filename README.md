# Logger Tests

This is a small repository to evaluate a couple of common logging stacks. 

Currently it contains:
- [Elastic Stack](./elastic/README.md) (Elasticsearch, Logstash, Grafana)
- [Grafana Stack](./loki/README.md) (Loki, Promtail, Grafana)
- [Quickwit Stack](./quickwit/README.md) (Quickwit, Vector)
- [PostgreSQL Stack](./postgres/README.md) (PostgreSQL, Vector, PostgREST, Grafana)

To try out one of the stacks, you should be able to open any of the subfolders of this repository and run:
```
docker compose up
```

## Testing
In order to test how the different stacks perform, you can adapt the following script.

```sh
# Start the monitoring stack
docker compose -f monitoring/docker-compose.yaml up -d 
open localhost:9080/d/uWhv0-04z # Open the grafana interface

# Start the logging stacks
docker compose -f elastic/docker-compose.yaml up -d 
docker compose -f loki/docker-compose.yaml up -d 
docker compose -f quickwit/docker-compose.yaml up -d 
docker compose -f postgres/docker-compose.yaml up -d 

# Wait for containers to reach a steady state, then run the test
./monitoring/run-test.sh

# Stop the logging stacks
docker compose -f elastic/docker-compose.yaml down -v 
docker compose -f loki/docker-compose.yaml down -v 
docker compose -f quickwit/docker-compose.yaml down -v 
docker compose -f postgres/docker-compose.yaml down -v 
```
