# Arkiver

## Overview

Arkiver is a powerful and flexible Bash script designed to help you manage and archive files efficiently. It allows you to specify source and destination directories, and set a maximum size for each archive. This tool is particularly useful for organizing large datasets, backups, or any scenario where you need to split files into manageable chunks.

## Features

- **Customizable Source and Destination**: Easily specify the source directory containing the files you want to archive and the destination directory where the archives will be saved.
- **Max Size Control**: Define the maximum size for each archive, ensuring that files are grouped intelligently based on your needs.
- **Recursive File Handling**: The script processes all files recursively, making it ideal for deeply nested directory structures.
- **User-Friendly Interface**: A comprehensive help menu guides you through the available options and their usage.

## Usage

### Basic Command

```bash
./Arkiver.sh
```

Running the script without any arguments will display the help menu, providing an overview of the available options.

### Options

- `-s, --source <source_directory>`: Specify the source directory. Default is the current directory (`.`).
- `-d, --destination <destination_directory>`: Specify the destination directory. Default is `~/Desktop/`.
- `-m, --max-size <size>`: Specify the maximum size of each archive. Default is `2G`. Supported formats include `K` (kilobytes), `M` (megabytes), and `G` (gigabytes).
- `--help, -h`: Display the help menu.

### Example

```bash
./Arkiver.sh -s /path/to/source -d /path/to/destination -m 1G
```

This command will archive files from `/path/to/source` to `/path/to/destination`, ensuring each archive is no larger than 1 gigabyte.

## Installation

1. **Clone the Repository**:

    ```bash
    git clone https://github.com/poursalavati/Arkiver.git
    cd Arkiver
    ```

2. **Make the Script Executable**:

    ```bash
    chmod +x Arkiver.sh
    ```

3. **Run the Script**:

    ```bash
    ./Arkiver.sh
    ```

## Requirements

- **Bash**: The script is written in Bash and requires a Bash shell to run.
- **tar**: The script uses `tar` for archiving files. This utility is typically pre-installed on most Unix-like systems.

---

Thank you for using Arkiver! Hope this tool simplifies your file archiving needs.
