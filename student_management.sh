#!/bin/bash
#
# Simple student management script.
#
# Features:
# 1. Create a new student file (overwrite).
# 2. Add a new student to an existing file.
# 3. Search for a student by ID.
# 4. Show basic statistics (number of students, average grade).
# 5. Exit.
#
# Each student record is stored on a single line in CSV format:
#   id,surname,name,id_card,grade,department
#

STUDENTS_FILE="students.txt"

create_student_file() {
  echo "Creating a new student file: $STUDENTS_FILE"
  echo "Enter student records in the format:"
  echo "id,surname,name,id_card,grade,department"
  echo "Press CTRL+D when you are done."
  cat > "$STUDENTS_FILE"
  echo "Student file '$STUDENTS_FILE' created."
}

add_student() {
  echo "Adding a new student to file: $STUDENTS_FILE"
  if [ ! -f "$STUDENTS_FILE" ]; then
    echo "File '$STUDENTS_FILE' does not exist. Creating a new one first."
    create_student_file
    return
  fi

  echo "Enter a single student record in the format:"
  echo "id,surname,name,id_card,grade,department"
  read -r record

  if [ -z "$record" ]; then
    echo "Empty input. Student not added."
    return
  fi

  echo "$record" >> "$STUDENTS_FILE"
  echo "Student added."
}

search_student_by_id() {
  if [ ! -f "$STUDENTS_FILE" ]; then
    echo "File '$STUDENTS_FILE' does not exist. Nothing to search."
    return
  fi

  echo -n "Enter student ID to search: "
  read -r search_id

  if [ -z "$search_id" ]; then
    echo "Empty ID. Aborting search."
    return
  fi

  echo "Searching for student with ID: $search_id"
  # We assume ID is the first field in the CSV line
  result=$(grep -E "^${search_id}," "$STUDENTS_FILE" || true)

  if [ -z "$result" ]; then
    echo "No student found with ID: $search_id"
  else
    echo "Student record(s) found:"
    echo "$result"
  fi
}

show_statistics() {
  if [ ! -f "$STUDENTS_FILE" ]; then
    echo "File '$STUDENTS_FILE' does not exist. No statistics available."
    return
  fi

  total_students=$(wc -l < "$STUDENTS_FILE")
  if [ "$total_students" -eq 0 ]; then
    echo "No students in file. No statistics available."
    return
  fi

  # Grade is assumed to be the 5th field in the CSV
  total_grade=$(awk -F',' '{sum += $5} END {print sum}' "$STUDENTS_FILE")
  avg_grade=$(awk -v sum="$total_grade" -v n="$total_students" 'BEGIN {if (n>0) print sum/n; else print 0}')

  echo "Statistics for file: $STUDENTS_FILE"
  echo "Total students: $total_students"
  echo "Average grade: $avg_grade"
}

quit_menu() {
  echo "Exiting student management script."
  exit 0
}

# Main menu loop
while true; do
  echo
  echo "==== Student Management Menu ===="
  echo "1. Create new student file"
  echo "2. Add new student"
  echo "3. Search student by ID"
  echo "4. Show statistics"
  echo "5. Exit"
  echo -n "Choose an option (1-5): "
  read -r choice

  case "$choice" in
    1) create_student_file ;;
    2) add_student ;;
    3) search_student_by_id ;;
    4) show_statistics ;;
    5) quit_menu ;;
    *) echo "Invalid choice. Please select 1–5." ;;
  esac
done
