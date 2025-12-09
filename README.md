# Code Collector

## Overview

Code Collector is a Windows batch script that recursively traverses a directory structure, collects all source code files, and consolidates them into a single text document. This tool is particularly useful for creating code snapshots, sharing complete project contexts with AI assistants, or archiving project structures.

## Features

* Recursively scans directories and subdirectories
* Excludes version control directories (.git)
* Omits LICENSE files, SQLite databases, and the script itself
* Preserves relative file paths for context
* Uses UTF-8 encoding for compatibility
* Creates clean separators between files in output

## Requirements

* Windows operating system
* PowerShell (for relative path calculation)

## Installation

Simply download collector.bat to your project directory.

## Usage

1. Navigate to your project directory in Command Prompt
2. Execute the script: collector.bat
3. The script will generate code.txt containing all project files

## Output Format

The generated code.txt file contains:

* Each file preceded by its relative path
* Clear separators between different files
* File contents in their original encoding (UTF-8)

## Excluded Items

The script automatically excludes:

* .git directories and their contents
* Files named LICENSE
* SQLite database files (.sqlite)
* The script itself (collector.bat)

## Customization

To modify exclusion patterns, edit the skipfile conditions in the script:
```text
if /i "%%~nxf"=="LICENSE" set skipfile=1
```
Add similar lines to exclude additional file patterns or names.

## Use Cases

* Creating complete project snapshots for AI analysis
* Generating documentation with embedded source code
* Archiving project structures for backup purposes
* Preparing code for review or sharing

## Limitations

* Windows-only (batch script)
* May not handle extremely large projects efficiently
* Binary files are skipped (only text files are collected)

## Author

[Evgenii Bykov](https://github.com/evbkv)

## License

GNU General Public License v3.0
