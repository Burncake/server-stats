#!/bin/bash
# server-stats.sh - Display basic server performance statistics

# Default: show all sections
SHOW_STATS=true
SHOW_NET=true
SHOW_EXTRA=true

# If arguments are given, disable default "show all"
if [[ $# -gt 0 ]]; then
    SHOW_STATS=false
    SHOW_NET=false
    SHOW_EXTRA=false
fi

print_help() {
    echo "Usage: $0 [OPTIONS]"
    echo
    echo "Options:"
    echo "  -s, --stats, --status     Show performance stats (CPU, memory, disk, top processes)"
    echo "  -n, --net, --network      Show network interfaces (name & IP)"
    echo "  -e, --ex, --extra         Show extra info (OS, uptime, load, users)"
    echo "  -h, --help                     Show this help message"
    echo
    echo "Examples:"
    echo "  $0                  Show everything"
    echo "  $0 --stats          Show only performance stats"
    echo "  $0 --net            Show only network info"
    echo "  $0 --extra          Show only extra info"
    echo "  $0 --stats --net    Show stats + network"
}

# Parse arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        -s|--stats|--status)
            SHOW_STATS=true
            ;;
        -n|--net|--network)
            SHOW_NET=true
            ;;
        -e|--ex|--extra)
            SHOW_EXTRA=true
            ;;
        -h|--help)
            print_help
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use --help to see available options."
            exit 1
            ;;
    esac
    shift
done

# ====================== STATS SECTION ======================
if $SHOW_STATS; then
    # CPU Usage
    CPU_USAGE=$(top -b -n2 -p 1 | fgrep "Cpu(s)" | tail -1 | \
        awk -F'id,' -v prefix="$prefix" '{ split($1, vs, ","); v=vs[length(vs)]; sub("%", "", v); printf "%s%.1f%%\n", prefix, 100 - v }')

    # Memory Usage
    MEM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
    MEM_USED=$(free -m | awk '/Mem:/ {print $3}')
    MEM_PERC=$(( MEM_USED * 100 / MEM_TOTAL ))

    # Disk Usage
    DISK_TOTAL=$(df -h / | awk 'NR==2 {print $2}')
    DISK_USED=$(df -h / | awk 'NR==2 {print $3}')
    DISK_PERC=$(df -h / | awk 'NR==2 {print $5}')

    echo "===== Server Performance Stats ====="
    echo "CPU Usage: $CPU_USAGE"
    echo "Memory Usage: $MEM_USED MB / $MEM_TOTAL MB (${MEM_PERC}%)"
    echo "Disk Usage: $DISK_USED / $DISK_TOTAL ($DISK_PERC)"

    echo -e "\nTop 5 Processes by CPU:"
    ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6

    echo -e "\nTop 5 Processes by Memory:"
    ps -eo pid,comm,%cpu,%mem --sort=-%mem | head -n 6
fi

# Endline
if $SHOW_STATS && ($SHOW_NET || $SHOW_EXTRA); then
    echo
fi

# ====================== NETWORK SECTION ======================
if $SHOW_NET; then
    echo -e "======== Network Interfaces ========"
    ip -o -4 addr show | awk '{print $2 ": " $4}'
fi

# Endline
if $SHOW_NET && $SHOW_EXTRA; then
    echo
fi

# ====================== EXTRA SECTION ======================
if $SHOW_EXTRA; then
    echo "============ Extra Info ============"
    echo "OS Version: $(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '\"')"
    echo "Uptime: $(uptime -p | awk '{$1=""; print substr($0, 2)}')"
    echo "Load Average: $(uptime | awk -F'load average:' '{print $2}')"
    echo "Logged In Users: $(who | wc -l)"
fi
