# Linux Server Health Monitor

A beginner-friendly Linux monitoring project built using Bash and Nginx.

## Objective

The purpose of this project is to monitor the health of a Linux server and detect common operational issues.

## What It Monitors

- CPU usage
- Memory usage
- Disk usage
- Nginx service status
- Overall server health

## Technologies

- Linux / Ubuntu
- Bash
- Nginx
- systemd
- Git
- GitHub

## Architecture

```text
Linux Server
     |
     +---- CPU
     |
     +---- Memory
     |
     +---- Disk
     |
     +---- Nginx
     |
     v
health-check.sh
     |
     v
Health Status
     |
  +--+---------+
  |            |
  OK        CRITICAL
