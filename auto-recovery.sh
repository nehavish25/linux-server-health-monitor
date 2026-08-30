#!/bin/bash

LOG_FILE="$HOME/linux-server-health-monitor/logs/auto-recovery.log"
SERVICE="nginx"

mkdir -p "$(dirname "$LOG_FILE")"

echo "========================================" | tee -a "$LOG_FILE"
echo "       NGINX AUTO-RECOVERY CHECK" | tee -a "$LOG_FILE"
echo "Time: $(date)" | tee -a "$LOG_FILE"
echo "========================================" | tee -a "$LOG_FILE"

if systemctl is-active --quiet "$SERVICE"
then
    echo "Nginx status: RUNNING [OK]" | tee -a "$LOG_FILE"
    echo "No action required." | tee -a "$LOG_FILE"

else
    echo "Nginx status: DOWN [CRITICAL]" | tee -a "$LOG_FILE"
    echo "Attempting to restart Nginx..." | tee -a "$LOG_FILE"

    sudo systemctl restart "$SERVICE"

    sleep 2

    if systemctl is-active --quiet "$SERVICE"
    then
        echo "Nginx status: RUNNING [RECOVERED]" | tee -a "$LOG_FILE"
        echo "Recovery successful." | tee -a "$LOG_FILE"
    else
        echo "Nginx status: DOWN [CRITICAL]" | tee -a "$LOG_FILE"
        echo "Automatic recovery FAILED." | tee -a "$LOG_FILE"
    fi
fi

echo "========================================" | tee -a "$LOG_FILE"

