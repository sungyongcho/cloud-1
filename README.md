# cloud-1

> Remote infrastructure provisioning with Ansible, Docker Compose, TLS, and restart-on-boot automation.

## Overview

An infrastructure automation project that provisions a Linux host and deploys a containerized WordPress platform. The goal is to make server setup reproducible: install Docker, configure user privileges, copy the application stack, build services, start Docker Compose, and register a systemd unit so the stack comes back after reboot.

This project was built as part of the 42 school system administration / cloud curriculum with [Christie Boutier](https://github.com/christie-b).

## Tech Stack

| Layer | Technologies |
|-------|-------------|
| Provisioning | Ansible roles and playbooks |
| Runtime | Docker, Docker Compose |
| Web | Nginx with self-signed TLS |
| Application | WordPress, PHP-FPM |
| Database | MariaDB |
| Administration | phpMyAdmin |
| Service management | systemd |
| Local Testing | Vagrant, VirtualBox |

## Key Features

- Ansible playbook split into reusable roles for user privileges, Docker setup, and application deployment
- Remote Docker installation with post-install user configuration
- Multi-container Docker Compose stack with Nginx, WordPress, MariaDB, and phpMyAdmin
- Self-signed TLS certificate generation for the required 42-style domain format
- Persistent MariaDB and WordPress volumes backed by host directories
- systemd service template enabling the stack to start automatically after reboot
- Vagrant target for local provisioning tests before remote deployment

## Architecture

```
cloud-1/
|-- playbook.yml
|-- inventory.yml
|-- roles/
|   |-- user_privileges/         # Remote user and Docker group setup
|   |-- docker/                  # Docker repository and engine installation
|   `-- inception/
|       |-- tasks/               # Deployment and restart-on-boot tasks
|       |-- templates/           # systemd service template
|       `-- files/inception/srcs/
|           |-- docker-compose.yml
|           `-- requirements/
|               |-- nginx/       # TLS reverse proxy
|               |-- mariadb/     # Database bootstrap
|               |-- wordpress/   # WordPress + PHP-FPM setup
|               `-- phpmyadmin/  # Database administration UI
`-- vagrant/                     # Local VM target
```

### Service Map

```
                 systemd
                    |
              docker-compose
                    |
      +-------------+-------------+
      |             |             |
    Nginx      WordPress/PHP     phpMyAdmin
      |             |
      +---------- MariaDB
```

## Getting Started

### Prerequisites

```bash
# Ansible
# Docker-compatible Linux target
# Vagrant + VirtualBox for local testing
```

### Installation

Create a local environment file before running the playbook:

```bash
git clone https://github.com/sungyongcho/cloud-1.git
cd cloud-1
cp roles/inception/files/inception/srcs/.env.example roles/inception/files/inception/srcs/.env
```

Adjust `inventory.yml` or `ansible.cfg` for the target host.

### Usage

```bash
# Provision the target host
ansible-playbook playbook.yml
```

For local testing, start the Vagrant target first:

```bash
cd vagrant
vagrant up
```

## What This Demonstrates

- **Infrastructure Automation**: Provisioned a remote Linux host through Ansible roles instead of manual setup.
- **Containerized Deployment**: Built and orchestrated a multi-service application stack with Docker Compose.
- **Operational Reliability**: Added TLS setup, persistent volumes, and systemd restart-on-boot behavior for a self-hosted service.

## License

This project was built as part of the 42 school curriculum.

---

*Part of [sungyongcho](https://github.com/sungyongcho)'s project portfolio.*
