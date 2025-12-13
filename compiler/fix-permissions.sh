#!/bin/bash
# Fix permissions for FPC build directories
# This script removes root-owned directories and recreates them

set -e

echo "Fixing permissions for FPC build directories..."

if [ -d aarch64 ]; then
    echo "Removing root-owned aarch64 directory..."
    sudo rm -rf aarch64
fi

# Create directories with proper permissions
mkdir -p aarch64/units/aarch64-darwin
mkdir -p aarch64/bin/aarch64-darwin
chmod -R u+w aarch64

echo "✅ Permissions fixed. You can now run: make cycle OPT=\"-n\""

