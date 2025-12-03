# Bash Automation Scripts

This repository contains two standalone Bash scripts demonstrating automation, file handling, simple data processing and interactive CLI menus.  
Both scripts are written in clean, portable Bash and can run on any Linux or macOS environment.

---

## 📁 Scripts Included

### 1️⃣ `file_organizer.sh`
A simple file-organization utility that:

- creates a target directory (if it does not already exist)
- generates 10 sample text files (`file1.txt` … `file10.txt`)
- moves **odd-numbered files** into a `first/` subdirectory
- moves **even-numbered files** into a `second/` subdirectory
- generates a `count.txt` summary with:
  - number of files in `first/`
  - number of files in `second/`

#### ▶️ Usage
```bash
./file_organizer.sh <directory_name>
```
Example:

```bash
./file_organizer.sh test_folder
```
After execution, folder structure will look like:

```sql
test_folder/
 ├── first/
 ├── second/
 ├── count.txt
```
2️⃣ student_management.sh
An interactive, menu-based CLI system that manages a student database stored in a text file.

Supports:

-creating a new student file

-adding a new student (CSV format line)

-searching for a student by ID

-showing basic statistics:

-total number of students

-average grade

▶️ Run the script
```bash
Copy code
./student_management.sh
```
You will see a menu:

```

==== Student Management Menu ====
1. Create new student file
2. Add new student
3. Search student by ID
4. Show statistics
5. Exit
```
Each student entry follows this format:

```bash
id,surname,name,id_card,grade,department
```
Example entry:
```
2122131,Stogianni,Maria,A12345,8.5,Informatics
```
🔧 Requirements
These scripts run on any Unix-like environment:

-Linux

-macOS

-WSL (Windows Subsystem for Linux)

Make sure the scripts are executable:

```bash
chmod +x file_organizer.sh student_management.sh
```
🎓 What This Repository Demonstrates
-Bash scripting fundamentals

-File and directory manipulation

-Conditional logic

-Loops & input handling

-Menu-driven CLI interfaces

-Lightweight data management with text files

#### 📜 License

This project is released under the MIT License.
