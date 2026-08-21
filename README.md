![Ansible](https://img.shields.io/badge/Ansible-EE0000?style=for-the-badge&logo=ansible&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)
![Azure](https://img.shields.io/badge/Microsoft_Azure-0078D4?style=for-the-badge&logo=microsoftazure&logoColor=white)
![Prometheus](https://img.shields.io/badge/Prometheus-E6522C?style=for-the-badge&logo=prometheus&logoColor=white)
![Grafana](https://img.shields.io/badge/Grafana-F46800?style=for-the-badge&logo=grafana&logoColor=white)
![Proxmox](https://img.shields.io/badge/Proxmox-E57000?style=for-the-badge&logo=proxmox&logoColor=white)
![OPNsense](https://img.shields.io/badge/OPNsense-D94F00?style=for-the-badge&logo=opnsense&logoColor=white)
![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

# 🏠 Homelab DevOps

> Home laboratory infrastructure demonstrating **Infrastructure as Code**,
> **containerization**, **monitoring**, and **cloud integration**.
> Built as a portfolio project for IT internship applications
> and preparation for **Microsoft AZ-900** certification.

---

## 🎯 Project Goals

- Build production-like infrastructure for hands-on DevOps/Cloud learning
- Practice **Infrastructure as Code** (Ansible, Terraform)
- Implement complete observability stack (metrics + uptime monitoring)
- Deploy and manage cloud resources on **Microsoft Azure** using Terraform
- Prepare for **AZ-900** certification
- Portfolio project showcasing real-world DevOps skills

---

## 🏗️ Architecture

![Architecture Diagram](docs/diagrams/architecture.png)

---

## 🛠️ Tech Stack

| Category              | Technology                     | Purpose                          |
|-----------------------|--------------------------------|----------------------------------|
| **Hypervisor**        | Proxmox VE 8.x                 | Virtualization platform          |
| **Firewall**          | OPNSense                       | Network security, routing, NAT   |
| **OS**                | Ubuntu Server 22.04 LTS        | Container host                   |
| **Automation**        | Ansible                        | Configuration management (IaC)   |
| **Cloud IaC**         | Terraform                      | Cloud infrastructure provisioning|
| **Cloud Provider**    | Microsoft Azure                | Public cloud (VMs, VNet, NSG)   |
| **Containers**        | Docker + Docker Compose        | Application containerization     |
| **Metrics**           | Prometheus                     | Time-series database (TSDB)      |
| **Visualization**     | Grafana                        | Dashboards and alerting          |
| **System Metrics**    | Node Exporter                  | OS-level metrics collection      |
| **Container Metrics** | cAdvisor                       | Container-level metrics          |
| **Uptime**            | Uptime Kuma                    | Service availability monitoring  |
| **Docker UI**         | Portainer                      | Container management interface   |
| **VCS**               | Git + GitHub                   | Version control                  |

---

## 📁 Repository Structure

```text
homelab-devops/
├── ansible/
│   ├── inventory/
│   │   └── hosts.yml              # Server inventory
│   └── playbooks/
│       ├── base-setup.yml         # Base OS configuration
│       └── docker-install.yml     # Docker CE installation
├── docker/
│   ├── docker-compose.yml         # Monitoring stack definition
│   └── .env.example               # Environment variables template
├── monitoring/
│   └── prometheus/
│       └── prometheus.yml         # Prometheus scrape configuration
├── terraform/
│   └── azure/
│       ├── main.tf                # Azure resources (RG, VNet, NSG, VM)
│       ├── variables.tf           # Parameterized configuration
│       ├── outputs.tf             # Public IP and SSH command
│       └── cloud-init.yml         # Nginx provisioning on boot
├── docs/
│   ├── diagrams/                  # Architecture diagrams (draw.io)
│   ├── access-guide.md            # SSH tunneling access guide
│   └── screenshots/               # Portfolio screenshots
├── scripts/                       # Utility scripts
├── opnsense/                      # OPNSense documentation
├── .github/
│   └── workflows/                 # CI/CD pipelines
├── .gitignore
├── LICENSE
└── README.md

✨ Features

✅ Implemented

 Virtualized infrastructure on Proxmox VE

 Network segmentation with OPNSense firewall

 Automated server configuration with Ansible

Package management

UFW firewall rules

Fail2Ban brute-force protection

Timezone and MOTD configuration

 Automated Docker installation via Ansible

 Complete monitoring stack in Docker Compose

 Metrics collection (Prometheus + exporters)

 Visualization with Grafana (2 dashboards)

 Uptime monitoring for critical services

 Container management UI (Portainer)

 Secure remote access via SSH tunneling

 All configuration versioned in Git

 Cloud infrastructure on Microsoft Azure via Terraform

Resource Group, VNet, Subnet, NSG, Public IP, Linux VM

Cloud-init automated Nginx provisioning

Full lifecycle management (init → plan → apply → destroy)

🚧 In Progress / Planned

 WireGuard VPN for seamless remote access

 Grafana Loki for centralized logging

 Alertmanager for Prometheus alerting

 Backup automation with rclone

 Kubernetes cluster (k3s) as next iteration

🚀 Quick Start

Prerequisites

Proxmox VE with OPNSense and Ubuntu Server VMs

SSH access configured with key-based authentication

Ansible installed on control node

1. Clone the repository

Bash

git clone git@github.com:marnoc24/homelab-devops.git
cd homelab-devops

2. Configure inventory

Edit ansible/inventory/hosts.yml with your server details.

3. Run base setup playbook

Bash

ansible-playbook -i ansible/inventory/hosts.yml ansible/playbooks/base-setup.yml

4. Install Docker

Bash

ansible-playbook -i ansible/inventory/hosts.yml ansible/playbooks/docker-install.yml

5. Deploy monitoring stack

Bash

cd docker
cp .env.example .env
# Edit .env with your credentials
docker compose up -d

6. Verify deployment

Bash

docker compose ps

All 6 containers should show status Up (healthy).

☁️ Cloud Infrastructure (Terraform & Azure)

The terraform/azure/ module provisions a complete, secure infrastructure
on Microsoft Azure using a declarative IaC approach. Designed as a hands-on
learning environment for AZ-900 preparation.

Deployed Resources

ResourceDetails



Resource Group

Logical container in switzerlandnorth

Virtual Network

10.1.0.0/16 with subnet 10.1.1.0/24

Network Security Group

Inbound rules: SSH (22), HTTP (80) only

Public IP

Static allocation, Standard SKU

Linux VM

Standard_D2s_v3 (2 vCPU, 8 GB RAM)

Cloud-init

Automatic Nginx installation on first boot

Deploy

Bash

cd terraform/azure/
terraform init
terraform plan
terraform apply -auto-approve

Verify

Bash

curl http://<PUBLIC_IP_FROM_OUTPUTS>
ssh -i ~/.ssh/azure_homelab azureuser@<PUBLIC_IP_FROM_OUTPUTS>

Destroy (cost control)

Bash

terraform destroy -auto-approve

🌐 Service Access

Services are not exposed to the internet for security reasons.
Access is provided through SSH tunneling via OPNSense.

Create SSH tunnel

Bash

ssh -p 2222 \
    -L 3000:10.0.0.10:3000 \
    -L 9090:10.0.0.10:9090 \
    -L 3001:10.0.0.10:3001 \
    -L 9443:10.0.0.10:9443 \
    -L 8080:10.0.0.10:8080 \
    user@your-opnsense-address

Or use SSH config

Add to ~/.ssh/config:

text

Host homelab
    HostName your-opnsense-address
    Port 2222
    User your-username
    LocalForward 3000 10.0.0.10:3000
    LocalForward 9090 10.0.0.10:9090
    LocalForward 3001 10.0.0.10:3001
    LocalForward 9443 10.0.0.10:9443
    ServerAliveInterval 60

Then simply: ssh homelab

Service URLs (via tunnel)

ServiceURLPurpose





Grafana

http://localhost:3000

Metrics visualization

Prometheus

http://localhost:9090

Metrics query interface

Uptime Kuma

http://localhost:3001

Service availability

Portainer

https://localhost:9443

Docker management

cAdvisor

http://localhost:8080

Container metrics UI

Node Exporter

http://localhost:9100

System metrics endpoint

📸 Screenshots

System Metrics Dashboard (Grafana - Node Exporter Full)

Comprehensive system dashboard displaying CPU pressure, memory usage,
disk space, network traffic, and system load. Uses community dashboard
ID 1860.

Container Metrics Dashboard (Grafana - cAdvisor)

Per-container resource monitoring showing CPU usage, memory allocation,
and network I/O for all running containers. Uses dashboard
ID 14282.

Prometheus Scrape Targets

All monitoring endpoints are healthy and being scraped every 15 seconds:

cadvisor — Docker container metrics

node-exporter — Host system metrics

prometheus — Self-monitoring

Uptime Monitoring (Uptime Kuma)

Availability monitoring dashboard tracking critical services with
100% uptime, including GitHub repository, OPNSense router,
Google DNS, and internal monitoring services.

Container Management (Portainer)

Web-based Docker management interface showing all 6 containers
running healthy in the monitoring stack.

🔐 Security Considerations

No public exposure — homelab services accessible only via SSH tunnel

Key-based SSH authentication (password auth disabled)

UFW firewall with default deny + explicit allow rules

Fail2Ban protection against SSH brute-force attempts

Segmented network — homelab isolated behind OPNSense

Azure NSG — cloud VM exposes only ports 22 and 80

Environment variables in .env (excluded from Git via .gitignore)

No hardcoded credentials in configuration files

Ephemeral cloud infrastructure — destroyed after use to minimize attack surface

📚 Learning Outcomes

Through this project I've gained hands-on experience with:

DevOps Practices

Infrastructure as Code (IaC) with Ansible playbooks and Terraform

Idempotent automation — safe to run playbooks multiple times

Declarative cloud provisioning — Terraform plan/apply/destroy lifecycle

Version control with Git (Conventional Commits)

Documentation-first approach — READMEs, diagrams, comments

Cloud Computing (Azure)

Resource Groups — logical lifecycle management

Virtual Networks & Subnets — cloud network segmentation

Network Security Groups — stateful firewall rules

Virtual Machines & SKUs — compute sizing and capacity planning

Azure Regions & Availability — data residency and latency considerations

Azure Policy — governance and compliance constraints

Cost Management — ephemeral infrastructure to control spending

Containerization

Docker fundamentals — images, containers, volumes, networks

Docker Compose — multi-container application orchestration

Container networking — service discovery via container names

Persistent storage — named volumes for data retention

Monitoring & Observability

Metrics collection — Prometheus scrape configuration

Time-series databases — data retention, storage optimization

Dashboarding — Grafana panels, queries, variables

Alerting concepts — health checks, uptime tracking

Networking

Network segmentation — separating homelab from home network

Firewall configuration — OPNSense rules, UFW on host, Azure NSG

NAT and port forwarding — SSH jump host pattern

SSH tunneling — secure remote access without VPN

Linux Administration

User management — sudo, groups (docker group)

Service management — systemd

Package management — apt, package repositories

File permissions and system security hardening

🎓 Certifications & Learning Path

🎯 In Progress: Microsoft AZ-900 (Azure Fundamentals) — September 2025

📖 Next: Microsoft AZ-104 (Azure Administrator)

📖 Future: HashiCorp Terraform Associate

🔗 Related Projects

homelab-infrastructure — Previous iteration (archived)

📄 License

This project is licensed under the MIT License — see the LICENSE file for details.

👤 Author

Marcin Nocuń

GitHub: @marnoc24

⭐ If this project helped you learn, consider giving it a star!
