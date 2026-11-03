#!/usr/bin/env bash
set -euo pipefail
echo "=== Team ==="
cat "$(dirname "$0")/TEAM_ID.txt"
echo "=== Python ==="
python3 --version
echo "=== MuJoCo ==="
"$HOME/pacbot_ws/.venv/bin/python" -c 'import mujoco; print(mujoco.__version__)'
echo "=== MQTT ==="
systemctl is-active mosquitto
echo "=== Repository ==="
test -d "$HOME/pacbot_ws/.git"
echo "Environment checks completed."
