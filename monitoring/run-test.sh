#!/bin/bash
set -eu

echo "$(date --rfc-3339=seconds) Starting logging test"

# Phase 1, slow logging containers
echo "$(date --rfc-3339=seconds) Starting 5 slow-logging containers (1 logs/s)"
for ((i=0; i<5; ++i)); do
    slow_loggers+=($(docker run -d -it --rm --name logger-$i mingrammer/flog -f json -d 1000ms -l))
    echo "$(date --rfc-3339=seconds) Started ${slow_loggers[$i]}"
done

total=10
for ((i=0; i<$total; ++i)); do
  echo "$(date --rfc-3339=seconds) Time remaining $(expr $(expr $total - $i) \* 60)s"
  sleep 60
done

echo "$(date --rfc-3339=seconds) Stopping slow-logging containers"
for ((i=0; i<5; ++i)); do
    docker kill "${slow_loggers[$i]}"
done

# Phase 2, fast logging containers
echo "$(date --rfc-3339=seconds) Starting 5 fast-logging containers (10 logs/s)"
for ((i=0; i<5; ++i)); do
    fast_loggers+=($(docker run -d -it --rm --name logger-$i mingrammer/flog -f json -d 100ms -l))
    echo "$(date --rfc-3339=seconds) Started ${fast_loggers[$i]}"
done

total=10
for ((i=0; i<$total; ++i)); do
  echo "$(date --rfc-3339=seconds) Time remaining $(expr $(expr $total - $i) \* 60)s"
  sleep 60
done

echo "$(date --rfc-3339=seconds) Stopping fast-logging containers"
for ((i=0; i<5; ++i)); do
    docker kill "${fast_loggers[$i]}"
done

echo "$(date --rfc-3339=seconds) Test completed"
