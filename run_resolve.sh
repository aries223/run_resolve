#!/bin/bash

# Set virtual environment directory
VENV_DIR="$HOME/resolve_venv"

# Check if virtual environment exists
if [ ! -d "$VENV_DIR/bin" ]; then
    echo "Virtual environment not found at $VENV_DIR!"
    exit 1
fi

# Activate the virtual environment
source "$VENV_DIR/bin/activate"

# Verify Python version
python --version | grep -q "3.13" || { echo "Wrong Python version"; deactivate; exit 1; }

# Run the application
exec /opt/resolve/bin/resolve "$@"
