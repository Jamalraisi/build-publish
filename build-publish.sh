#!/bin/bash

# Define variables
DOTNET_VERSION="8.0.x"
PROJECT_DIR=$(pwd) # Assuming the script is run in the project directory
PUBLISH_DIR="$PROJECT_DIR/publish"

# Step 1: Install .NET SDK (Optional if .NET is already installed)
# This checks if .NET SDK is installed and installs it if missing.
if ! dotnet --version &>/dev/null; then
    echo ".NET SDK is not installed. Please install it manually from https://dotnet.microsoft.com/download."
    exit 1
fi

# Step 2: Restore dependencies (install Nuget packages)
echo "Restoring dependencies..."
dotnet restore
if [ $? -ne 0 ]; then
    echo "Failed to restore dependencies."
    exit 1
fi

# Step 3: Build the project
echo "Building the project..."
dotnet build --no-restore
if [ $? -ne 0 ]; then
    echo "Failed to build the project."
    exit 1
fi

# Step 4: Publish the project
echo "Publishing the project..."
dotnet publish -c Release -o $PUBLISH_DIR
if [ $? -ne 0 ]; then
    echo "Failed to publish the project."
    exit 1
fi

echo "Project published to $PUBLISH_DIR"

# Optional Step: Upload the artifacts somewhere (You can use a cloud service, scp, etc.)
# Example: Upload to remote server via SCP
# echo "Uploading artifacts..."
# scp -r $PUBLISH_DIR user@yourserver:/path/to/destination

echo "Script execution completed successfully."
