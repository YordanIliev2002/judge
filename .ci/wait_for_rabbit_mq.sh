#!/bin/bash

URL="http://localhost:15672"
INTERVAL_SECONDS=10
MAX_RETRIES=5

check_health() {
  curl --silent --fail "$URL" > /dev/null
  return $?
}

retries=0
while (( retries < MAX_RETRIES )); do
  if check_health; then
    echo "Service is healthy!"
    exit 0
  else
    echo "Health check failed. Retrying... ($((retries + 1))/$MAX_RETRIES)"
    ((retries++))
    sleep "$INTERVAL_SECONDS"
  fi
done

echo "Service is unhealthy after $MAX_RETRIES retries."
exit 1
