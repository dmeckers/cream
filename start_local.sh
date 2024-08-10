#!/bin/bash

# Prompt for Docker login
docker login

# Check if the login was successful
if [ $? -eq 0 ]; then
  echo "Login successful. Starting Docker Compose..."
  docker-compose -f docker-compose.yml up -d --build
else
  echo "Login failed. Please check your credentials."
  exit 1
fi