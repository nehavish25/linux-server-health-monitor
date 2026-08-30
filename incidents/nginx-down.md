# Incident Report: Nginx Service Down

## Incident Summary

Nginx web server became unavailable because the Nginx service was stopped.

## Severity

High

## Impact

The web server was unavailable and HTTP requests could not be served.

## Detection

The `health-check.sh` monitoring script detected:

Nginx: DOWN [CRITICAL]

Overall Status: CRITICAL

## Investigation

### 1. Checked Nginx service

```bash
systemctl status nginx
