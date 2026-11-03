#!/usr/bin/env bash
set -euo pipefail
TOPIC="pacbot/task0/eYRC1062"
MESSAGE="PacBot Task 0 MQTT test OK for eYRC#1062"
TMP="$(mktemp)"
trap 'rm -f "$TMP"' EXIT

mosquitto_sub -h localhost -t "$TOPIC" -C 1 > "$TMP" &
PID=$!
sleep 1
mosquitto_pub -h localhost -t "$TOPIC" -m "$MESSAGE"

for _ in $(seq 1 20); do
  grep -Fqx "$MESSAGE" "$TMP" && { echo "MQTT PASSED"; kill "$PID" 2>/dev/null || true; exit 0; }
  sleep .25
done

echo "MQTT FAILED"
kill "$PID" 2>/dev/null || true
exit 1
