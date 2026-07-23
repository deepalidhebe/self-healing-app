# 🚀 Self-Healing Application using AWS, Docker & Linux

## 📖 Project Overview

This project demonstrates a simple **Self-Healing Application** running on AWS EC2.

Imagine a website is running inside a Docker container.

If the container stops unexpectedly, a monitoring script automatically detects the problem and starts the application again without human intervention.

This is a basic example of a **Self-Healing System**, a concept widely used in DevOps and Site Reliability Engineering (SRE).

***

# 🎯 Project Goal

Build a system that can:

✅ Run a web application

✅ Deploy using Docker

✅ Monitor the application

✅ Detect failures automatically

✅ Recover automatically

✅ Log recovery events

***

# 🏗️ Architecture

```text
                AWS EC2
                    │
                    ▼
          Docker Container
                    │
                    ▼
            Flask Application
                    │
                    ▼
            monitor.sh Script
                    │
                    ▼
               Cron Job
                    │
                    ▼
         Automatic Restart
```

***

# 🛠️ Technologies Used

| Technology         | Purpose                |
| ------------------ | ---------------------- |
| AWS EC2            | Virtual Server         |
| Amazon Linux 2023  | Operating System       |
| Python Flask       | Web Application        |
| Docker             | Containerization       |
| Linux Shell Script | Monitoring             |
| Cron               | Automation             |
| Git                | Version Control        |
| GitHub             | Source Code Repository |

***

# 📂 Project Structure

```text
self-healing-app/

├── app.py
├── requirements.txt
├── Dockerfile
├── monitor.sh
├── monitor.log
└── .gitignore
```

***

# Step 1 – Launch AWS EC2 Instance

Launch a:

```text
Instance Type : t3.micro
OS            : Amazon Linux 2023
Storage       : 10 GB
```

Allow Ports:

```text
22   SSH
5000 Application
```

Connect using SSH:

```bash
ssh -i my-key.pem ec2-user@PUBLIC-IP
```

***

# Step 2 – Install Git

```bash
sudo dnf install git -y
```

Verify:

```bash
git --version
```

***

# Step 3 – Install Docker

Install Docker:

```bash
sudo dnf install docker -y
```

Start Docker:

```bash
sudo systemctl start docker
```

Enable Docker:

```bash
sudo systemctl enable docker
```

Add user to Docker group:

```bash
sudo usermod -aG docker ec2-user
```

Disconnect and reconnect SSH.

Verify:

```bash
docker ps
```

***

# Step 4 – Create Project Directory

```bash
mkdir self-healing-app

cd self-healing-app
```

Verify:

```bash
pwd
```

***

# Step 5 – Create Application

Create:

```bash
nano app.py
```

Paste:

```python
from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    return "Hello DevOps World"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
```

Save the file.

***

# Step 6 – Create Requirements File

Create:

```bash
nano requirements.txt
```

Add:

```text
flask
```

***

# Step 7 – Create Dockerfile

Create:

```bash
nano Dockerfile
```

Paste:

```dockerfile
FROM python:3.11-slim

WORKDIR /app

COPY . .

RUN pip install -r requirements.txt

EXPOSE 5000

CMD ["python","app.py"]
```

***

# Step 8 – Build Docker Image

```bash
docker build -t website:v1 .
```

Verify:

```bash
docker images
```

Expected:

```text
website     v1
```

***

# Step 9 – Run Container

```bash
docker run -d \
--name website \
-p 5000:5000 \
website:v1
```

Check:

```bash
docker ps
```

***

# Step 10 – Test Application

Inside EC2:

```bash
curl localhost:5000
```

Output:

```text
Hello DevOps World
```

Browser:

```text
http://PUBLIC-IP:5000
```

***

# Step 11 – Create Monitoring Script

Create:

```bash
nano monitor.sh
```

Paste:

```bash
#!/bin/bash

echo "$(date) - Script executed" >> /home/ec2-user/self-healing-app/monitor.log

if ! /usr/bin/docker ps --format "{{.Names}}" | grep -q "^website$"
then
    echo "$(date) - Website stopped" >> /home/ec2-user/self-healing-app/monitor.log

    /usr/bin/docker start website

    echo "$(date) - Website restarted" >> /home/ec2-user/self-healing-app/monitor.log
fi
```

Save file.

Grant permission:

```bash
chmod +x monitor.sh
```

***

# Step 12 – Manual Test

Stop website:

```bash
docker stop website
```

Run script:

```bash
./monitor.sh
```

Check:

```bash
docker ps
```

Website should restart automatically.

***

# Step 13 – Install Cron

Install:

```bash
sudo dnf install cronie -y
```

Start:

```bash
sudo systemctl start crond
```

Enable:

```bash
sudo systemctl enable crond
```

Verify:

```bash
sudo systemctl status crond
```

***

# Step 14 – Schedule Automatic Monitoring

Open:

```bash
crontab -e
```

Add:

```bash
* * * * * /home/ec2-user/self-healing-app/monitor.sh
```

Verify:

```bash
crontab -l
```

Expected:

```bash
* * * * * /home/ec2-user/self-healing-app/monitor.sh
```

***

# Step 15 – Verify Self-Healing

Stop application:

```bash
docker stop website
```

Wait 1 minute.

Check:

```bash
docker ps
```

Expected:

```text
website
Up X seconds
```

View logs:

```bash
cat monitor.log
```

Expected:

```text
Script executed
Website stopped
Website restarted
```

***

# ✅ Troubleshooting Section

## Problem 1 – Docker Permission Denied

Error:

```text
permission denied while trying to connect to Docker daemon
```

Fix:

```bash
sudo usermod -aG docker ec2-user
```

Reconnect SSH.

***

## Problem 2 – Cron Service Not Found

Error:

```text
Unit crond.service not found
```

Fix:

```bash
sudo dnf install cronie -y
```

***

## Problem 3 – Cron Access Denied

Error:

```text
Access denied
```

Fix:

Use:

```bash
sudo systemctl start crond
```

instead of:

```bash
systemctl start crond
```

***

## Problem 4 – GitHub Push Rejected

Error:

```text
non-fast-forward
```

Cause:

GitHub repository already contained a commit.

Fix:

```bash
git push -u origin main --force
```

***

# What I Learned

✅ AWS EC2

✅ Linux Commands

✅ Docker

✅ Python Flask

✅ Shell Scripting

✅ Cron Jobs

✅ Monitoring

✅ Logging

✅ Git & GitHub

✅ Self-Healing Concepts

✅ Troubleshooting Real Production-Like Issues

***

# Future Improvements

* Email Alerts
* Slack Alerts
* Jenkins Integration
* CI/CD Pipeline
* Docker Hub Integration
* Terraform Automation
* Kubernetes Deployment
* Health Check API
* Monitoring Dashboard

***

# Author

**Deepali Dhebe**

DevOps Learning Project – Self-Healing Application on AWS 🚀

***
