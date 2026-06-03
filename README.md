<!-- SPDX-License-Identifier: Apache-2.0 -->
# Development tooling guide

This document describes the tools required for LamaDist development, how to set up your environment, and how to use the build system.

https://www.apache.org/licenses/LICENSE-2.0.txt

## Table of Contents

- [Overview](#overview)
- [Required Tools](#required-tools)
- [Developer Environment Setup](#developer-environment-setup)
- [mise Task Reference](#mise-task-reference)
- [GitHub Actions CI](#github-actions-ci)
- [Container Python Dependencies](#container-python-dependencies)
- [KAS Configuration](#kas-configuration)
- [Troubleshooting](#troubleshooting)

---

## Overview

LamaDist uses a containerized build approach to ensure reproducible builds across different development environments. The core tools are:

- **mise**: Single CLI entrypoint — polyglot tool/runtime manager and task runner ([mise.jdx.dev](https://mise.jdx.dev/))
- **podman** (preferred) or Docker: Provides the isolated, reproducible KAS build container
- **KAS**: Declarative Yocto/OE project setup and build tool (runs inside the container)
- **uv** + `pyproject.toml`: Python dependency management inside the container
- **GitVersion**: Automatic semantic versioning

Host developers only need **`mise`**, **`podman`** (or Docker), and **`git`**. No Python, venv, or Make is required on the host — mise manages any needed tools.

---

## Required Tools

### Host System Requirements

**Operating System**: Linux (Ubuntu 22.04 LTS recommended) or WSL2

**Minimum Hardware**:
- CPU: 4+ cores (8+ recommended)
- RAM: 8 GB minimum (16+ GB recommended)
- Disk: 100+ GB free space (SSD strongly recommended)
- Internet: For downloading sources and dependencies

### Core Tools

#### 1. Mise

**Purpose**: Polyglot tool manager and task runner — single CLI entrypoint for all development tasks

**Installation**: See the [mise Getting Started guide](https://mise.jdx.dev/getting-started.html) for the latest instructions.
For details/help about repository configuration, see [Ubuntu 26.04 repository management](https://linuxconfig.org/complete-apt-package-management-guide-on-ubuntu-26-04#managing-repositories)

```bash
# Ensure that the keyring directory exists with correct mode
sudo install --directory --mode 755 /usr/share/keyrings

# Download Mise repository key
curl --silent --fail --show-error https://mise.en.dev/gpg-key.pub | sudo gpg --dearmor -o /usr/share/keyrings/mise-archive-keyring.gpg

# Setup Mise repository source
{
cat <<EOF
Types: deb
URIs: https://mise.en.dev/deb
Suites: stable
Components: main
Signed-By: /usr/share/keyrings/mise-archive-keyring.gpg
EOF
} | sudo tee /etc/apt/sources.list.d/mise-archive.sources

# Update APT lists and install Mise
sudo apt update
sudo apt install -y mise

# Verify that Mise is installed succesfully
mise --version

              _                                        __
   ____ ___  (_)_______        ___  ____        ____  / /___ _________
  / __ `__ \/ / ___/ _ \______/ _ \/ __ \______/ __ \/ / __ `/ ___/ _ \
 / / / / / / (__  )  __/_____/  __/ / / /_____/ /_/ / / /_/ / /__/  __/
/_/ /_/ /_/_/____/\___/      \___/_/ /_/     / .___/_/\__,_/\___/\___/
                                            /_/                 by @jdx
2026.5.18 linux-x64 (2026-05-31)
```
