#!/bin/bash

cd() {
  builtin cd "$@" && check_venv
}

check_venv() {
  if [[ "$PWD" == "$HOME/repos"* ]] || [[ "$PWD" == "$HOME/repos" ]]; then
    if [[ -f "venv/bin/activate" ]]; then
      source "venv/bin/activate"
    else
      read -p "No virtual environment found. Do you want to create one? (y/n) " choice
      if [[ $choice =~ ^[Yy]$ ]]; then
        python3 -m venv venv
        source "venv/bin/activate"
        
        # Initialize Git repository
        git init --initial-branch=main

        # Download comprehensive .gitignore from GitHub
        curl -sSL https://raw.githubusercontent.com/github/gitignore/master/Python.gitignore -o .gitignore
        
        # Add .gitignore to the first commit
        git add .gitignore
        git commit -m "Initial commit with .gitignore"
      fi
    fi
  fi
}
