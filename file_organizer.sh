#!/bin/bash
#
# Simple file organizer script.
# Usage: ./file_organizer.sh <directory_name>
#
# - Creates the directory if it does not exist.
# - Creates two subdirectories: "first" and "second".
# - Generates 10 text files (file1.txt ... file10.txt).
# - Moves odd-numbered files to "first" and even-numbered files to "second".
# - Creates a count.txt file with the number of files in each subdirectory.

set -e

# Check if a directory name was provided
if [ -z "$1" ]; then
  echo "Usage: $0 <directory_name>"
  exit 1
fi

TARGET_DIR="$1"

# Check if directory exists
if [ ! -d "$TARGET_DIR" ]; then
  echo "Directory '$TARGET_DIR' does not exist."
  echo "Creating new directory: $TARGET_DIR"
  mkdir -p "$TARGET_DIR"
else
  echo "Directory '$TARGET_DIR' already exists. Please try again with a new name."
  exit 0
fi

# Change into the target directory
cd "$TARGET_DIR" || exit 1

# Create subdirectories
mkdir -p first second

echo "Creating sample text files..."

# Create 10 sample files: file1.txt ... file10.txt
for i in $(seq 1 10); do
  filename="file${i}.txt"
  echo "This is file number ${i}" > "$filename"
done

echo "Distributing files into 'first' and 'second'..."

# Move odd files to 'first' and even files to 'second'
for i in $(seq 1 10); do
  filename="file${i}.txt"
  if [ $((i % 2)) -eq 1 ]; then
    mv "$filename" first/
  else
    mv "$filename" second/
  fi
done

# Create count.txt with statistics
echo "Creating count.txt..."

{
  echo "Files in 'first':"
  ls -1 first | wc -l
  echo
  echo "Files in 'second':"
  ls -1 second | wc -l
} > count.txt

echo "Done."
echo "Directory structure created under: $(pwd)"
echo "Summary stored in: count.txt"
