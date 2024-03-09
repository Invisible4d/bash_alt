#!/bin/bash

# Default value for number of entries
num_entries=8

# Function to display usage information
usage() {
    echo "Usage: $0 [-d] [-n N] directory"
    echo "Options:"
    echo "  -d     List both directories and files within the specified directory"
    echo "  -n N   Return the top N entries (default is 8)"
    exit 1
}

# Parse command line options
while getopts ":dn:" opt; do
    case $opt in
        d)
            list_files=true
            ;;
        n)
            num_entries=$OPTARG
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            usage
            ;;
        :)
            echo "Option -$OPTARG requires an argument." >&2
            usage
            ;;
    esac
done

# Shift the options
shift $((OPTIND - 1))

# Check if the directory argument is provided
if [ $# -eq 0 ]; then
    echo "Directory argument is missing." >&2
    usage
fi

# Get the directory to check
directory=$1

# Check if the directory exists
if [ ! -d "$directory" ]; then
    echo "Directory '$directory' does not exist." >&2
    exit 1
fi

# Command to get disk usage for directories and files
if [ "$list_files" = true ]; then
    du_output=$(du -ah "$directory" 2>/dev/null | sort -rh | head -n "$num_entries")
else
    du_output=$(du -h --max-depth=1 "$directory" 2>/dev/null | sort -rh | head -n "$num_entries")
fi

# Display the output
echo "$du_output"