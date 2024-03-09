#!/bin/bash

# Check if number of arguments is correct
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 source_directory destination_directory"
    exit 1
fi

# Source directory
source_dir="$1"

# Destination directory
dest_dir="$2"

# Check if source directory exists
if [ ! -d "$source_dir" ]; then
    echo "Source directory '$source_dir' does not exist."
    exit 1
fi

# Check if destination directory exists, if not, create it
if [ ! -d "$dest_dir" ]; then
    mkdir -p "$dest_dir"
fi

# Generate timestamp
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")

# Create backup filename with timestamp
backup_filename="backup_$timestamp.tar.gz"

# Create tar archive of source directory
tar -czf "$dest_dir/$backup_filename" "$source_dir"

# Check if the backup was successful
if [ $? -eq 0 ]; then
  echo "Backup was successfully created: $dest_dir/$backup_filename"
else
  echo "Error: Backup failed."
  exit 1
fi