#!/bin/bash

# Default values for source, destination, and max size
DEFAULT_SOURCE='.'
DEFAULT_DESTINATION='~/Desktop/'
MAX_SIZE=2G

# Function to display help message
display_help() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "-s --source <source_directory> - Specify the source directory (default: .)"
    echo "-d --destination <destination_directory> - Specify the destination directory (default: ~/Desktop)"
    echo "-m --max-size <size> - Specify the maximum size of each archive (default: 2G)"
}

# Check if no arguments are provided
if [[ $# -eq 0 ]]; then
  display_help
  exit 0
fi

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    -s|--source)
      SOURCE="$2"
      shift # past argument
      shift # past value
      ;;
    -d|--destination)
      DESTINATION="$2"
      shift # past argument
      shift # past value
      ;;
    -m|--max-size)
      MAX_SIZE="$2"
      shift # past argument
      shift # past value
      ;;
    --help|-h)
      display_help
      exit 0
      ;;
    *)
      echo "Unknown argument: $1"
      display_help
      exit 1
      ;;
  esac
done

# Set default values if not specified
SOURCE=${SOURCE:-$DEFAULT_SOURCE}
DESTINATION=${DESTINATION:-$DEFAULT_DESTINATION}

# Convert max size to bytes
case "$MAX_SIZE" in
  *K | *k)
    MAX_SIZE_BYTES=$(( ${MAX_SIZE%?} * 1024 ))
    ;;
  *M | *m)
    MAX_SIZE_BYTES=$(( ${MAX_SIZE%?} * 1024 * 1024 ))
    ;;
  *G | *g)
    MAX_SIZE_BYTES=$(( ${MAX_SIZE%?} * 1024 * 1024 * 1024 ))
    ;;
  *)
    echo "Invalid max size format. Use K, M, or G."
    exit 1
    ;;
esac

# Create destination directory if it doesn't exist
mkdir -p "$DESTINATION"

current_size=0
archive_number=1
archive_files=()

# Find all files recursively and process them
while IFS= read -r -d '' item; do
  item_size=$(stat -f%z "$item")
  
  if [[ $item_size -gt $MAX_SIZE_BYTES ]]; then
    # If item is larger than max size, archive it separately
    tar -czvf "$DESTINATION/${archive_number}.tar.gz" "$item"
    archive_number=$((archive_number + 1))
  elif [[ $((current_size + item_size)) -gt $MAX_SIZE_BYTES ]]; then
    # Create new archive if adding this item exceeds max size
    tar -czvf "$DESTINATION/${archive_number}.tar.gz" "${archive_files[@]}"
    archive_files=("$item")
    current_size=$item_size
    archive_number=$((archive_number + 1))
  else
    # Add item to current archive
    archive_files+=("$item")
    current_size=$((current_size + item_size))
  fi
done < <(find "$SOURCE" -type f -print0)

# Add any remaining files from current archive to destination
if [[ ${#archive_files[@]} -gt 0 ]]; then
  tar -czvf "$DESTINATION/${archive_number}.tar.gz" "${archive_files[@]}"
fi

echo "Archives created in $DESTINATION."
