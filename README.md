# 🖥️ Linux Server Health Monitor & Auto-Recovery

A Linux server monitoring and automated recovery solution built using **AWS EC2, Bash, Nginx, Cron, Amazon CloudWatch, and Amazon SNS**.

The project continuously monitors server health, detects Nginx failures, automatically attempts service recovery, publishes system metrics to CloudWatch, and sends alerts through SNS when resource usage crosses configured thresholds.


## 🚀 Project Overview

Managing production servers requires continuous monitoring of system resources and critical services.

This project was built to demonstrate a simple **DevOps/SRE-style monitoring and incident recovery workflow**:


                    Linux EC2 Server
                           │
             ┌─────────────┴─────────────┐
             │                           │
       Health Check                  Nginx Monitor
          Script                         │
             │                           │
      CPU / Memory / Disk          Failure Detection
             │                           │
             │                      Auto Restart
             │                           │
             └─────────────┬─────────────┘
                           │
                        Cron Job
                           │
                           ▼
                  CloudWatch Agent
                           │
                 ┌─────────┴─────────┐
                 │                   │
             Metrics              Logs
                 │                   │
                 ▼                   ▼
          CloudWatch             CloudWatch
            Metrics                 Logs
                 │
                 ▼
          CloudWatch Alarms
                 │
                 ▼
                SNS
                 │
                 ▼
            Email Alert


            🎯 Objectives

The main objectives of this project were:

Monitor Linux server health
Monitor CPU utilization
Monitor memory utilization
Monitor disk utilization
Monitor Nginx availability
Automatically recover Nginx when it stops
Schedule health checks using Cron
Publish custom Linux metrics to CloudWatch
Create CloudWatch alarms
Send alerts using SNS
Maintain operational and recovery logs
Demonstrate an end-to-end monitoring and incident-response workflow

🛠️ Technologies Used
Technology	Purpose
AWS EC2	Linux server infrastructure
Amazon Linux	Operating system
Nginx	Web server / monitored service
Bash	Health-check and recovery scripts
Cron	Scheduled monitoring
systemd	Nginx service management
CloudWatch Agent	Custom metrics and log collection
Amazon CloudWatch	Monitoring and alarms
Amazon SNS	Email notifications
Git	Version control
GitHub	Source code and documentation


📁 Project Structure
linux-server-health-monitor/
│
├── cloudwatch/
│   └── config.json
│
├── incidents/
│   └── incident documentation
│
├── screenshots/
│   ├── health-check-healthy.png
│   ├── cloudwatch-memory-metric.png
│   ├── cloudwatch-memory-alarm.png
│   ├── cloudwatch-cpu-metrics.png
│   ├── cloudwatch-cpu-alarm.png
│   ├── sns-email-alert.png
│   └── nginx-auto-recovery.png
│
├── auto-recovery.sh
├── health-check.sh
├── .gitignore
└── README.md
🔍 Health Monitoring

The health-check.sh script collects important Linux server information.

It checks:

Hostname
Server uptime
CPU usage
Memory usage
Disk usage
Nginx service status
Overall server health

Example output:

========================================
       LINUX SERVER HEALTH REPORT
========================================

Hostname       : ip-172-31-3-60.ap-south-1.compute.internal
Uptime         : up 1 hour, 18 minutes
CPU Usage      : 82% [WARNING]
Memory Usage   : 26% [OK]
Disk Usage     : 25% [OK]
Nginx          : RUNNING [OK]

Overall Status : HEALTHY
========================================
       HEALTH CHECK COMPLETED
========================================
Health Check Screenshot
<img width="1096" height="377" alt="health-check-healthy" src="https://github.com/user-attachments/assets/fcefb930-aa54-47b6-9087-1bdacf8556d0" />


🔄 Nginx Automatic Recovery

The project includes an automated recovery mechanism for Nginx.

The recovery script checks whether Nginx is running.

If Nginx is detected as down:

The failure is logged.
The script attempts to restart Nginx.
The service status is checked again.
The recovery result is recorded.

Example incident:

========================================
       NGINX AUTO-RECOVERY CHECK
========================================

Nginx status: DOWN [CRITICAL]

Attempting to restart Nginx...

Nginx status: RUNNING [RECOVERED]

Recovery successful.

========================================

This demonstrates a basic automated incident-response workflow.

Recovery Flow
Nginx Running
     │
     ▼
Health Check
     │
     ▼
Is Nginx Running?
     │
   ┌─┴─┐
  YES  NO
   │    │
   │    ▼
   │  Restart Nginx
   │    │
   │    ▼
   │  Verify Service
   │    │
   │    ▼
   │  Recovery Logged
   │
   ▼
Continue Monitoring
Nginx Recovery Screenshot
<img width="1917" height="1012" alt="nginx-auto-recovery" src="https://github.com/user-attachments/assets/ed14b4ea-2d98-4fb4-aeb3-36cb1294e6a3" />


⏰ Cron Automation

The health monitoring process is scheduled using Linux Cron.

This allows the server to perform periodic health checks automatically without manual intervention.

Example workflow:

Cron
  │
  ▼
health-check.sh
  │
  ├── CPU
  ├── Memory
  ├── Disk
  └── Nginx
        │
        ▼
      Logs

The recovery process also runs automatically based on the configured schedule.

☁️ Amazon CloudWatch Monitoring

The Amazon CloudWatch Agent is installed and configured on the EC2 instance.

The agent collects Linux system metrics and publishes them to CloudWatch.

Metrics Collected
CPU
cpu_usage_user
cpu_usage_system
cpu_usage_idle
Memory
mem_used_percent
Disk
disk_used_percent

Metrics are collected at a 60-second interval.

CloudWatch Configuration

The configuration is available in:

cloudwatch/config.json
CloudWatch CPU Metrics

CloudWatch Memory Metrics

🚨 CloudWatch Alarms

CloudWatch alarms were configured to detect abnormal resource utilization.

CPU Alarm

Alarm:

Linux-Server-CPU-High

Condition:

CPU usage > 80%

Evaluation period:

5 minutes

Statistic:

Average
CPU Alarm Screenshot
<img width="1917" height="1026" alt="cloudwatch-memory-alarm2" src="https://github.com/user-attachments/assets/c7c11844-2eb3-41bd-a04f-9e08e929a251" />
<img width="1917" height="1027" alt="cloudwatch-memory-metric-alarm" src="https://github.com/user-attachments/assets/abb461d3-b32c-443c-88f1-48a06a5b0d17" />


Memory Alarm

Alarm:

Linux-Server-Memory-High

Condition:

Memory usage > 70%

Evaluation period:

5 minutes

Statistic:

Average
Memory Alarm Screenshot
<img width="1917" height="1026" alt="cloudwatch-memory-alarm2" src="https://github.com/user-attachments/assets/3073aed4-441f-4d67-b61b-0ba4744ee935" />

📧 Amazon SNS Notifications

Amazon SNS is used to send email notifications when CloudWatch alarms enter the alarm state.

Notification flow:

EC2
 │
 ▼
CloudWatch Agent
 │
 ▼
CloudWatch Metrics
 │
 ▼
CloudWatch Alarm
 │
 ▼
Amazon SNS
 │
 ▼
Email Notification

SNS topic:

linux-server-health-alerts

The configured email endpoint receives notifications when an alarm is triggered.

SNS Screenshot

<img width="1917" height="1026" alt="sns-email-alert" src="https://github.com/user-attachments/assets/4b28ea55-4538-4684-8376-eefcd6ebfcb4" />


🧪 Testing & Validation

The monitoring solution was tested using multiple scenarios.

Test 1 — Server Health

The health-check script successfully reported:

CPU
Memory
Disk
Nginx
Overall Status
Test 2 — Nginx Failure

Nginx was intentionally stopped to simulate a service failure.

Expected workflow:

Nginx DOWN
     ↓
Health Check Detects Failure
     ↓
Auto-Recovery Triggered
     ↓
Nginx Restarted
     ↓
Service Verified
     ↓
Recovery Logged

Result:

Nginx status: DOWN [CRITICAL]
Attempting to restart Nginx...
Nginx status: RUNNING [RECOVERED]
Recovery successful.
Test 3 — CPU Monitoring

CPU metrics were published to CloudWatch using the CloudWatch Agent.

Metrics verified:

cpu_usage_user
cpu_usage_system
cpu_usage_idle
Test 4 — Memory Monitoring

Memory utilization was successfully published to CloudWatch.

Metric:

mem_used_percent

The CloudWatch memory alarm was configured with a 70% threshold.

Test 5 — Alerting

CloudWatch alarms were connected to Amazon SNS to provide email notifications when configured thresholds are exceeded.

📊 Monitoring & Recovery Workflow

The complete workflow is:

                 EC2 Linux Server
                        │
                        ▼
                Health Check Script
                        │
             ┌──────────┴──────────┐
             │                     │
        Resource Check         Nginx Check
             │                     │
       CPU/Memory/Disk          Running?
             │                     │
             │                ┌────┴────┐
             │               YES       NO
             │                │         │
             │                │    Restart Nginx
             │                │         │
             │                │    Verify Recovery
             │                │         │
             └────────┬───────┴─────────┘
                      │
                      ▼
                 CloudWatch
                      │
                ┌─────┴─────┐
                │           │
             Metrics       Logs
                │
                ▼
          CloudWatch Alarms
                │
                ▼
               SNS
                │
                ▼
          Email Notification
🔐 Security Considerations

No AWS access keys or secret credentials should be stored in this repository.

The EC2 instance uses an IAM role for AWS service access.

The CloudWatch Agent runs using the configured cwagent user.

Sensitive information should always be excluded using .gitignore.

📈 Future Improvements

Potential improvements include:

Add CPU, memory and disk recovery actions
Add application health checks
Add HTTP endpoint monitoring
Add ALB health monitoring
Add automated incident creation
Integrate with AWS Systems Manager
Add CloudWatch dashboards
Add Slack or Microsoft Teams notifications
Add Infrastructure as Code using Terraform
Add CI/CD pipeline
Add Docker/container monitoring
Add centralized log analysis
Add automated remediation using AWS Lambda
💡 What I Learned

Through this project, I gained hands-on experience with:

Linux server administration
Bash scripting
Cron automation
systemd service management
Nginx troubleshooting
Automated service recovery
AWS EC2
Amazon CloudWatch
CloudWatch Agent
CloudWatch alarms
Amazon SNS
IAM roles
Linux monitoring
Incident detection
Incident recovery
Git and GitHub
🎯 Key DevOps/SRE Concepts Demonstrated

This project demonstrates practical concepts including:

Monitoring

CPU / Memory / Disk / Service Health

Alerting

CloudWatch → Alarm → SNS → Email

Automation

Cron → Health Check → Recovery

Incident Response

Failure Detection → Remediation → Verification → Logging

Observability

Metrics + Logs + Alerts
👩‍💻 Author

Neha Vishwakarma

GitHub:

https://github.com/nehavish25

⭐ Project Summary

This project demonstrates how a Linux server can be monitored and partially self-healed using a combination of Linux automation and AWS monitoring services.

The solution combines:

Bash + Linux + Nginx + Cron + EC2 + CloudWatch + SNS

to create an automated monitoring and recovery workflow suitable as a foundation for production-style DevOps/SRE practices.
