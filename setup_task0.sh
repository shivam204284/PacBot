#!/usr/bin/env bash
set -euo pipefail
SUDO=""
[[ "$(id -u)" -eq 0 ]] || SUDO="sudo"

echo "Preparing PacBot Task 0 for eYRC#1062..."

$SUDO apt-get update
$SUDO apt-get install -y git python3 python3-pip python3-venv python3-dev build-essential   libglfw3 libglew2.2 libosmesa6 mosquitto mosquitto-clients

if [[ -d "$HOME/pacbot_ws/.git" ]]; then
  git -C "$HOME/pacbot_ws" pull --ff-only
else
  git clone https://github.com/eYantra-Robotics-Competition/eYRC_26-27_PacBot.git "$HOME/pacbot_ws"
fi

python3 -m venv "$HOME/pacbot_ws/.venv"
source "$HOME/pacbot_ws/.venv/bin/activate"
python -m pip install --upgrade pip setuptools wheel
python -m pip install "mujoco==3.1.1"

$SUDO systemctl enable --now mosquitto

python - <<'PY'
import mujoco
print("MuJoCo:", mujoco.__version__)
assert mujoco.__version__ == "3.1.1"
print("MuJoCo 3.1.1 import: OK")
PY

echo "Setup complete. Team ID: eYRC#1062"
echo "Next: run verify_mujoco_viewer.py, mqtt_test.sh, then the official evaluator."
