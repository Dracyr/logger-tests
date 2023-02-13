# Monitoring

This is a simple setup to run Grafana, prometheus and a local docker exporter to fetch metrics for them. It is pre-configured to attempt to visualize the logs from the other stacks in this repo.

## Usage

Simply start it by running

```sh
docker compose up
```

## Manual Usage

```sh
project="loki"

curl \
    --data-urlencode "query=sum by(container_label_com_docker_compose_service) (avg_over_time(container_memory_working_set_bytes{container_label_com_docker_compose_project=\"$project\",container_label_com_docker_compose_service!='flog'}[1m])) / (1024 * 1024)" \
    --data-urlencode "start=1676219758.704" \
    --data-urlencode "end=1676223358.704" \
    --data-urlencode "step=14" \
    http://localhost:9090/api/v1/query_range
```
