![Ansible](https://img.shields.io/badge/Ansible-EE0000?style=for-the-badge&logo=ansible&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
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
- Prepare for **AZ-900** certification
- Portfolio project showcasing real-world DevOps skills

---

## 🏗️ Architecture

> 🚧 **Diagram coming soon** — will be created with draw.io

<!--
Planned architecture diagram will show:
- Internet → Home Router → OPNSense (WAN/LAN)
- Proxmox VE host with virtualized OPNSense + Ubuntu Server
- Internal network 10.0.0.0/24 (vmbr1 bridge)
- Docker container stack on Ubuntu
- SSH tunneling path from laptop to internal services
-->

![Architecture Diagram](docs/diagrams/architecture.png)

---

## 🛠️ Tech Stack

| Category              | Technology                     | Purpose                          |
|-----------------------|--------------------------------|----------------------------------|
| **Hypervisor**        | Proxmox VE 8.x                 | Virtualization platform          |
| **Firewall**          | OPNSense                       | Network security, routing, NAT   |
| **OS**                | Ubuntu Server 22.04 LTS        | Container host                   |
| **Automation**        | Ansible                        | Configuration management (IaC)   |
| **Containers**        | Docker + Docker Compose        | Application containerization     |
| **Metrics**           | Prometheus                     | Time-series database (TSDB)      |
| **Visualization**     | Grafana                        | Dashboards and alerting          |
| **System Metrics**    | Node Exporter                  | OS-level metrics collection      |
| **Container Metrics** | cAdvisor                       | Container-level metrics          |
| **Uptime**            | Uptime Kuma                    | Service availability monitoring  |
| **Docker UI**         | Portainer                      | Container management interface   |
| **VCS**               | Git + GitHub                   | Version control                  |
| **Cloud (planned)**   | Microsoft Azure + Terraform    | Cloud infrastructure (IaC)       |
| **CI/CD (planned)**   | GitHub Actions                 | Automated pipelines              |

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
├── docs/
│   ├── diagrams/                  # Architecture diagrams (draw.io)
│   ├── access-guide.md            # SSH tunneling access guide
│   └── screenshots/               # Portfolio screenshots
├── terraform/                     # (planned) Azure infrastructure
├── scripts/                       # (planned) Utility scripts
├── opnsense/                      # OPNSense documentation
├── .github/
│   └── workflows/                 # (planned) CI/CD pipelines
├── .gitignore
├── LICENSE
└── README.md
```

---

## ✨ Features

### ✅ Implemented

- [x] Virtualized infrastructure on Proxmox VE
- [x] Network segmentation with OPNSense firewall
- [x] Automated server configuration with Ansible
  - Package management
  - UFW firewall rules
  - Fail2Ban brute-force protection
  - Timezone and MOTD configuration
- [x] Automated Docker installation via Ansible
- [x] Complete monitoring stack in Docker Compose
- [x] Metrics collection (Prometheus + exporters)
- [x] Visualization with Grafana (2 dashboards)
- [x] Uptime monitoring for critical services
- [x] Container management UI (Portainer)
- [x] Secure remote access via SSH tunneling
- [x] All configuration versioned in Git

### 🚧 In Progress / Planned

- [ ] Terraform infrastructure on Microsoft Azure
- [ ] GitHub Actions CI/CD pipeline (linting, validation)
- [ ] WireGuard VPN for seamless remote access
- [ ] Grafana Loki for centralized logging
- [ ] Alertmanager for Prometheus alerting
- [ ] Backup automation with rclone
- [ ] Kubernetes cluster (k3s) as next iteration

---

## 🚀 Quick Start

### Prerequisites

- Proxmox VE with OPNSense and Ubuntu Server VMs
- SSH access configured with key-based authentication
- Ansible installed on control node

### 1. Clone the repository

```bash
git clone git@github.com:marnoc24/homelab-devops.git
cd homelab-devops
```

### 2. Configure inventory

Edit `ansible/inventory/hosts.yml` with your server details.

### 3. Run base setup playbook

```bash
ansible-playbook -i ansible/inventory/hosts.yml ansible/playbooks/base-setup.yml
```

### 4. Install Docker

```bash
ansible-playbook -i ansible/inventory/hosts.yml ansible/playbooks/docker-install.yml
```

### 5. Deploy monitoring stack

```bash
cd docker
cp .env.example .env
# Edit .env with your credentials
docker compose up -d
```

### 6. Verify deployment

```bash
docker compose ps
```

All 6 containers should show status `Up (healthy)`.

---

## 🌐 Service Access

Services are **not exposed to the internet** for security reasons.
Access is provided through **SSH tunneling** via OPNSense.

### Create SSH tunnel

```bash
ssh -p 2222 \
    -L 3000:10.0.0.10:3000 \
    -L 9090:10.0.0.10:9090 \
    -L 3001:10.0.0.10:3001 \
    -L 9443:10.0.0.10:9443 \
    -L 8080:10.0.0.10:8080 \
    user@your-opnsense-address
```

### Or use SSH config

Add to `~/.ssh/config`:

```text
Host homelab
    HostName your-opnsense-address
    Port 2222
    User your-username
    LocalForward 3000 10.0.0.10:3000
    LocalForward 9090 10.0.0.10:9090
    LocalForward 3001 10.0.0.10:3001
    LocalForward 9443 10.0.0.10:9443
    ServerAliveInterval 60
```

Then simply: `ssh homelab`

### Service URLs (via tunnel)

| Service       | URL                    | Purpose                       |
|---------------|------------------------|-------------------------------|
| Grafana       | http://localhost:3000  | Metrics visualization         |
| Prometheus    | http://localhost:9090  | Metrics query interface       |
| Uptime Kuma   | http://localhost:3001  | Service availability          |
| Portainer     | https://localhost:9443 | Docker management             |
| cAdvisor      | http://localhost:8080  | Container metrics UI          |
| Node Exporter | http://localhost:9100  | System metrics endpoint       |

---

## 📸 Screenshots

### System Metrics Dashboard (Grafana - Node Exporter Full)

![Grafana Node Exporter](docs/screenshots/grafana-node-exporter.jpg)

Comprehensive system dashboard displaying CPU pressure, memory usage,
disk space, network traffic, and system load. Uses community dashboard
[ID 1860](https://grafana.com/grafana/dashboards/1860).

### Container Metrics Dashboard (Grafana - cAdvisor)

![Grafana cAdvisor](docs/screenshots/grafana-cadvisor.jpg)

Per-container resource monitoring showing CPU usage, memory allocation,
and network I/O for all running containers. Uses dashboard
[ID 14282](https://grafana.com/grafana/dashboards/14282).

### Prometheus Scrape Targets

![Prometheus Targets](docs/screenshots/prometheus-targets.jpg)

All monitoring endpoints are healthy and being scraped every 15 seconds:
- **cadvisor** — Docker container metrics
- **node-exporter** — Host system metrics
- **prometheus** — Self-monitoring

### Uptime Monitoring (Uptime Kuma)

![Uptime Kuma](docs/screenshots/uptime-kuma.jpg)

Availability monitoring dashboard tracking critical services with
100% uptime, including GitHub repository, OPNSense router,
Google DNS, and internal monitoring services.

### Container Management (Portainer)

![Portainer](docs/screenshots/portainer-containers.jpg)

Web-based Docker management interface showing all 6 containers
running healthy in the monitoring stack.

---

## 🔐 Security Considerations

- **No public exposure** — services accessible only via SSH tunnel
- **Key-based SSH authentication** (password auth disabled)
- **UFW firewall** with default deny + explicit allow rules
- **Fail2Ban** protection against SSH brute-force attempts
- **Segmented network** — homelab isolated behind OPNSense
- **Environment variables** in `.env` (excluded from Git via `.gitignore`)
- **No hardcoded credentials** in configuration files

---

## 📚 Learning Outcomes

Through this project I've gained hands-on experience with:

### DevOps Practices

- **Infrastructure as Code** (IaC) with Ansible playbooks
- **Idempotent automation** — safe to run playbooks multiple times
- **Version control** with Git (Conventional Commits)
- **Documentation-first approach** — READMEs, diagrams, comments

### Containerization

- **Docker fundamentals** — images, containers, volumes, networks
- **Docker Compose** — multi-container application orchestration
- **Container networking** — service discovery via container names
- **Persistent storage** — named volumes for data retention

### Monitoring & Observability

- **Metrics collection** — Prometheus scrape configuration
- **Time-series databases** — data retention, storage optimization
- **Dashboarding** — Grafana panels, queries, variables
- **Alerting concepts** — health checks, uptime tracking

### Networking

- **Network segmentation** — separating homelab from home network
- **Firewall configuration** — OPNSense rules, UFW on host
- **NAT and port forwarding** — SSH jump host pattern
- **SSH tunneling** — secure remote access without VPN

### Linux Administration

- **User management** — sudo, groups (docker group)
- **Service management** — systemd
- **Package management** — apt, package repositories
- **File permissions** and system security hardening

---

## 🎓 Certifications & Learning Path

- 🎯 **In Progress:** Microsoft AZ-900 (Azure Fundamentals) — September 2025
- 📖 **Next:** Microsoft AZ-104 (Azure Administrator)
- 📖 **Future:** HashiCorp Terraform Associate

---

## 🔗 Related Projects

- [iac-lab-azure](https://github.com/marnoc24/iac-lab-azure) — Azure infrastructure with Terraform
- [homelab-infrastructure](https://github.com/marnoc24/homelab-infrastructure) — Previous iteration (archived)

---

## 📄 License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.

---

## 👤 Author

**Marcin Nocuń**

- GitHub: [@marnoc24](https://github.com/marnoc24)

---

⭐ **If this project helped you learn, consider giving it a star!**
