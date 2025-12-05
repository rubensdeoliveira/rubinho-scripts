#!/usr/bin/env bash

set -e

echo "=============================================="
echo "========= [01] CONFIGURING GIT ==============="
echo "=============================================="

# Use provided values or prompt for them
if [ -z "$GIT_USER_NAME" ]; then
    read -p "Enter your Git user name: " GIT_USER_NAME
    if [ -z "$GIT_USER_NAME" ]; then
        echo "⚠️  Git user name is required"
        exit 1
    fi
fi

if [ -z "$GIT_USER_EMAIL" ]; then
    read -p "Enter your Git email: " GIT_USER_EMAIL
    if [ -z "$GIT_USER_EMAIL" ]; then
        echo "⚠️  Git email is required"
        exit 1
    fi
fi

echo "Setting up Git identity..."
echo "  Name: $GIT_USER_NAME"
echo "  Email: $GIT_USER_EMAIL"
git config --global user.name "$GIT_USER_NAME"
git config --global user.email "$GIT_USER_EMAIL"
git config --global init.defaultBranch main
git config --global color.ui auto

echo "=============================================="
echo "============== [01] DONE ===================="
echo "=============================================="
echo "▶ Next, run: bash 02-install-zsh.sh"

