# LZER0
![image](/Images/lzer0.full.png)

LZER0: a cost-effective multi-purpose GNSS platform (Hardware and Software) developed by OGS for seismic and geophysical monitoring.

## 🔍 Overview
- 📇 Based on u‑blox M8T GNSS receiver + Raspberry Pi Zero W.
- 🧰 Processes data with RTKLIB (real-time RTK/PPK).
- 🖥️ Includes Bash scripts, Ansible provisioning, and web interface for fleet management

## 🚀 Getting Started

To fully utilize an LZER0 device, you will need to set up the hardware, deploy and configure the device's operating system and software, and optionally integrate it into a centralized management system.

### Choose Your Path
- 🔧 **I want to build the hardware** → Continue to the [Hardware Guide](#-hardware-guide) section below
- 💻 **I want to deploy and configure devices** → Go to the [LZER0 Deployment and Provisioning](https://hub.geosciences.cloud/git/geosciencesir-devop/ogs_dev/lzer0_provisioning) repository
- 🌐 **I want to set up centralized management** → Check out the [GNSS-Central-Config](https://hub.geosciences-ir.it/git/geosciencesir-devop/ogs_dev/gnss-central-config) system
- 📚 **I want to understand the complete system** → Continue reading this guide and explore the [research publications](#-articles-and-informations-available-at)

### LZER0 Deployment and Provisioning
The LZER0 Deployment and Provisioning repository is crucial for bringing new Raspberry Pi units to an operative state, allowing them to join a pool of already deployed boards. This process involves a combination of ad-hoc OS image building using pi-gen and IT automation with Ansible.

**Key Stages:**
- **Image Building Stage:** Utilizes pi-gen to create a Raspberry Pi OS Lite image, which is then written to the SD cards of the RPis. This stage includes custom scripts (90-crspi) for installing extra packages, disabling unneeded hardware/services, setting up NetworkManager, and populating a custom.toml file for first-boot scripts.

  - **Customization:** Before the first boot, you can apply board-specific customizations to the SD card, such as setting a custom hostname and providing client-specific VPN configurations.

- **Provisioning Stage:** Uses Ansible playbooks to define and run tasks on all hosts in the inventory.

  - **Inventory Population:** The Ansible inventory can be populated manually or dynamically using Avahi for discovery of IP addresses and hostnames.

  - **Playbooks:** A comprehensive set of Ansible playbooks (main.yaml) is provided for tasks like disabling requiretty, configuring fstab, installing/updating apt packages, managing user groups and SSH keys, setting up NTP, configuring the ufw firewall, establishing persistent VPN connections, syncing root and home directories, installing Python packages with pip, deploying RTKLIB, setting up the GNSS module web interface, configuring PiJuice, and managing crontab entries.

For detailed instructions, please refer to the README.md in the LZER0 Deployment and Provisioning repository.

### GNSS-Central-Config

The GNSS-Central-Config system enables centralized management of a pool of LZER0 receivers. This system facilitates defining and distributing device configurations, monitoring their status, updating parameters, and coordinating the behavior of the entire GNSS network. This is particularly useful for fleet management, allowing programmatic updates to keep configuration files and certificates in sync across all deployed boards.



## 📦 Components

<table>
  <thead>
    <tr>
      <th style="width: 200px;">Repo</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td colspan="2"><strong>🧰 Software</strong></td>
    </tr>
    <tr>
      <td><a href="https://github.com/OGS-GNSS/homebin_lzer0">homebin_lzer0</a></td>
      <td>Contains scripts, tools, and utility software necessary for the daily operation of the LZER0 receiver. It includes tools for starting services, managing GNSS files, communicating with peripherals, and other system operations. It is the central component that defines the behavior of the device once it is powered on.</td>
    </tr>
    <tr>
      <td><a href="https://github.com/OGS-GNSS/homecfg_lzer0">homecfg_lzer0</a></td>
      <td>Contains examples of the configuration file related to the operation of the LZER0 receiver. Some files are used directly, others are dynamically regenerated at provisioning or boot time.</td>
    </tr>
    <tr>
      <td colspan="2"><strong>🌐 Web-based configuration system</strong></td>
    </tr>
    <tr>
      <td><a href="https://hub.geosciences-ir.it/git/geosciencesir-devop/ogs_dev/gnss-central-config">GNSS-Central-Config</a> (soon public)</td>
      <td>Web interface for centralized management of a pool of LZER0 receivers. It allows you to define and distribute device configurations, monitor their status, update parameters, and coordinate the behavior of the entire GNSS network.</td>
    </tr>
    <tr>
      <td colspan="2"><strong>⚙️ Deployment system</strong></td>
    </tr>
    <tr>
      <td><a href="https://hub.geosciences.cloud/git/geosciencesir-devop/ogs_dev/lzer0_provisioning">LZER0 Deployment and Provisioning</a> (soon public)</td>
      <td>Main repository for the automatic deployment and provisioning of lzer0 devices. It manages the entire device lifecycle: from initial power-up to final configuration. Includes scripts for installation, cloning of the required repositories, and network and service setup.</td>
    </tr>
    <tr>
      <td><a href="https://github.com/OGS-GNSS/lzer0_generic_assets">Assets to be configured</a></td>
      <td>Contains the customizable assets needed to adapt the provisioning system to your operating environment. This repository is automatically cloned by the provisioning system.</td>
    </tr>
  </tbody>
</table>

## 🛠️ Hardware Guide

This repository contains all the hardware designs, schematics, and documentation needed to build LZER0 devices.

### What You'll Find Here

#### Core Hardware Designs
- **PCB schematics** - Complete electrical designs for LZER0 boards
- **PCB layouts** - Ready-to-manufacture Gerber files
- **Bill of Materials (BOM)** - Component lists with part numbers
- **Assembly instructions** - Step-by-step hardware assembly guides
- **Mechanical drawings** - Enclosure and mounting specifications

#### Key Components
- **u-blox M8T GNSS receiver module** - Professional-grade timing receiver
- **Raspberry Pi Zero W** - ARM-based computing platform with WiFi
- **Custom interface PCB** - Connects GNSS receiver to Raspberry Pi
- **Power management** - Efficient power supply and distribution
- **I/O interfaces** - GPIO, serial, and expansion connectors

### Manufacturing Your LZER0

1. **Download design files** from the `/hardware/` directory
2. **Source components** using the provided BOM
3. **Manufacture PCBs** using the Gerber files with your preferred fabricator
4. **Assemble hardware** following the assembly guide
5. **Test hardware** before software installation

### Hardware Variants

LZER0 supports multiple hardware configurations:
- **Basic LZER0** - Core GNSS receiver functionality
- **LZER0-Plus** - Extended I/O and sensor interfaces
- **LZER0-Field** - Ruggedized version for outdoor deployments
- **LZER0-Network** - Enhanced connectivity options

## 📄 Articles and informations available at:
- https://doi.org/10.3390/s22218314<br>
- https://doi.org/10.5194/egusphere-egu2020-9506<br>
- http://dx.doi.org/10.13140/RG.2.2.22750.05447<br>
- http://dx.doi.org/10.13140/RG.2.2.32319.61605<br>
- https://doi.org/10.3390/s22010350<br>
