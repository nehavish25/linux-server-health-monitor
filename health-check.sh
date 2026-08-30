#!/bin/bash

LOG_FILE="$HOME/linux-server-health-monitor/logs/health-check.log"

mkdir -p "$(dirname "$LOG_FILE")"

echo "========================================" | tee -a "$LOG_FILE"
echo "       LINUX SERVER HEALTH REPORT" | tee -a "$LOG_FILE"
echo "========================================" | tee -a "$LOG_FILE"

HOSTNAME=$(hostname)
UPTIME=$(uptime -p)

echo "" | tee -a "$LOG_FILE"
echo "Hostname       : $HOSTNAME" | tee -a "$LOG_FILE"
echo "Uptime         : $UPTIME" | tee -a "$LOG_FILE"

# CPU

CPU=$(top -bn1 | awk -F',' '/Cpu\(s\)/ {
    gsub(/[^0-9.]/, "", $4)
    print 100 - $4
}')

CPU=$(printf "%.0f" "$CPU")

if [ "$CPU" -lt 70 ]; then
    CPU_STATUS="OK"
elif [ "$CPU" -lt 85 ]; then
    CPU_STATUS="WARNING"
else
    CPU_STATUS="CRITICAL"
fi

echo "CPU Usage      : $CPU% [$CPU_STATUS]" | tee -a "$LOG_FILE"

# MEMORY

MEMORY=$(free | awk '/Mem:/ {
    printf "%.0f", ($3/$2)*100
}')

if [ "$MEMORY" -lt 70 ]; then
    MEMORY_STATUS="OK"
elif [ "$MEMORY" -lt 85 ]; then
    MEMORY_STATUS="WARNING"
else
    MEMORY_STATUS="CRITICAL"
fi

echo "Memory Usage   : $MEMORY% [$MEMORY_STATUS]" | tee -a "$LOG_FILE"

# DISK

DISK=$(df / | awk 'NR==2 {print $5}' | tr -d '%')

if [ "$DISK" -lt 80 ]; then
    DISK_STATUS="OK"
elif [ "$DISK" -lt 90 ]; then
    DISK_STATUS="WARNING"
else
    DISK_STATUS="CRITICAL"
fi

echo "Disk Usage     : $DISK% [$DISK_STATUS]" | tee -a "$LOG_FILE"

# NGINX

if systemctl is-active --quiet nginx
then
    NGINX_STATUS="OK"
    NGINX_MESSAGE="RUNNING"
else
    NGINX_STATUS="CRITICAL"
    NGINX_MESSAGE="DOWN"
fi

echo "Nginx          : $NGINX_MESSAGE [$NGINX_STATUS]" | tee -a "$LOG_FILE"

# OVERALL STATUS

if [ "$CPU_STATUS" = "CRITICAL" ] || \
   [ "$MEMORY_STATUS" = "CRITICAL" ] || \
   [ "$DISK_STATUS" = "CRITICAL" ] || \
   [ "$NGINX_STATUS" = "CRITICAL" ]
then
    OVERALL="CRITICAL"

elif [ "$CPU_STATUS" = "WARNING" ] || \
     [ "$MEMORY_STATUS" = "WARNING" ] || \
     [ "$DISK_STATUS" = "WARNING" ]
then
    OVERALL="WARNING"

else
    OVERALL="HEALTHY"
fi

echo "" | tee -a "$LOG_FILE"
echo "Overall Status : $OVERALL" | tee -a "$LOG_FILE"

echo "========================================" | tee -a "$LOG_FILE"
echo "       HEALTH CHECK COMPLETED" | tee -a "$LOG_FILE"
echo "========================================" | tee -a "$LOG_FILE"

echo "Health check completed at $(date)" >> "$LOG_FILE"
