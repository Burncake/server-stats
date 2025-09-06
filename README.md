# Server Stats

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Shell](https://img.shields.io/badge/shell-bash-green.svg)
![Platform](https://img.shields.io/badge/platform-linux%20%7C%20unix-lightgrey.svg)

A simple Bash script to display basic server performance statistics and system information.

Inspired by [roadmap.sh](https://roadmap.sh/projects/server-stats)

## Features

- **Performance Stats**: CPU usage, memory usage, disk usage, and top processes
- **Network Information**: Network interfaces with IP addresses
- **System Information**: OS version, uptime, load average, and logged-in users
- **Flexible Display**: Show all information or specific sections only

## Usage

### Show Everything (Default)
```bash
./server-stats.sh
```

### Show Specific Sections
```bash
# Performance stats only
./server-stats.sh --stats

# Network information only
./server-stats.sh -n

# Combine multiple sections
./server-stats.sh --extra --network
```

### Options

| Option | Description |
|--------|-------------|
| `-s, --stats, --status` | Show performance stats (CPU, memory, disk, top processes) |
| `-n, --net, --network` | Show network interfaces (name & IP) |
| `-e, --ex, --extra` | Show extra info (OS, uptime, load, users) |
| `-h, --help` | Show help message |

## Sample Output

```
===== Server Performance Stats =====
CPU Usage: 15.2%
Memory Usage: 2048 MB / 8192 MB (25%)
Disk Usage: 45G / 100G (45%)

Top 5 Processes by CPU:
    PID COMMAND         %CPU %MEM
   1234 firefox         12.5  8.2
   5678 chrome          8.1   6.4
   9012 code            3.2   4.1

Top 5 Processes by Memory:
    PID COMMAND         %CPU %MEM
   1234 firefox         12.5  8.2
   5678 chrome          8.1   6.4
   9012 code            3.2   4.1

======== Network Interfaces ========
lo: 127.0.0.1/8
eth0: 192.168.1.100/24
wlan0: 10.0.0.50/24

============ Extra Info ============
OS Version: Ubuntu 22.04.3 LTS
Uptime: 2 days, 5 hours, 32 minutes
Load Average:  0.45, 0.52, 0.48
Logged In Users: 2
```

## Installation

1. Download the script:
   ```bash
   wget https://raw.githubusercontent.com/Burncake/server-stats/main/server-stats.sh
   ```

2. Make it executable:
   ```bash
   chmod +x server-stats.sh
   ```

3. Run it:
   ```bash
   ./server-stats.sh
   ```

## Requirements

- Linux/Unix system
- Bash shell
- Standard utilities: `top`, `free`, `df`, `ps`, `ip`, `uptime`, `who`

## License

This project is open source and available under the [MIT License](LICENSE).
