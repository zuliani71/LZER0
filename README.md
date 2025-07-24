# LZER0
![image](/Images/lzer0.full.png)

LZER0: a cost-effective multi-purpose GNSS platform (Hardware and Software) developed by OGS for surveying measurements and for monitoring tasks.

## 🔍 Overview
- 📇 Based on u‑blox M8T GNSS receiver + Raspberry Pi Zero W.
- 🧰 Processes data with RTKLIB (real-time RTK/PPK).
- 🖥️ Includes Bash scripts, Ansible provisioning, and web interface for fleet management

## 🚀 Getting Started

To fully utilize an LZER0 device, you will need to set up the hardware, deploy and configure the device's operating system and software, and optionally integrate it into a centralized management system.

### Choose Your Path
- 🔧 **I want to build the hardware** → Continue to the [Hardware Guide](#%EF%B8%8F-hardware-guide) section below
- 💻 **I want to deploy and configure devices** → Go to the [LZER0 Deployment and Provisioning](https://hub.geosciences.cloud/git/geosciencesir-devop/ogs_dev/lzer0_provisioning) repository
- 🌐 **I want to set up the web-based centralized management and configuration system** → Check out the [GNSS-Central-Config](https://hub.geosciences-ir.it/git/geosciencesir-devop/ogs_dev/gnss-central-config) system
- 📚 **I want to understand the complete system** → Continue reading this guide and explore the [research publications](#-articles-and-informations-available-at)

### LZER0 Deployment and Provisioning
The LZER0 Deployment and Provisioning repository is crucial for bringing new Raspberry Pi units to an operative state, allowing them to join a pool of already deployed boards. This process involves a combination of ad-hoc OS image building using pi-gen and IT automation with Ansible.

**Key Stages:**
- **Image Building Stage:** Utilizes pi-gen to create a Raspberry Pi OS Lite image, which is then written to the SD cards of the RPis. This stage includes custom scripts (90-crspi) for installing extra packages, disabling unneeded hardware/services, setting up NetworkManager, and populating a custom.toml file for first-boot scripts.

  - **Customization:** Before the first boot, you can apply board-specific customizations to the SD card, such as setting a custom hostname and providing client-specific VPN configurations.

- **Provisioning Stage:** Uses Ansible playbooks to define and run tasks on all hosts in the inventory.

  - **Inventory Population:** The Ansible inventory can be populated manually or dynamically using Avahi for discovery of IP addresses and hostnames.

  - **Playbooks:** A comprehensive set of Ansible playbooks (main.yaml) is provided for tasks like disabling requiretty, configuring fstab, installing/updating apt packages, managing user groups and SSH keys, setting up NTP, configuring the ufw firewall, establishing persistent VPN connections, syncing root and home directories, installing Python packages with pip, deploying RTKLIB, setting up the GNSS module web interface, configuring PiJuice, and managing crontab entries.

For detailed instructions, please refer to the `README.md` in the [LZER0 Deployment and Provisioning](https://hub.geosciences.cloud/git/geosciencesir-devop/ogs_dev/lzer0_provisioning) repository.

### GNSS-Central-Config

The [GNSS-Central-Config](https://hub.geosciences-ir.it/git/geosciencesir-devop/ogs_dev/gnss-central-config) system enables centralized management of a pool of LZER0 receivers. This system facilitates defining and distributing device configurations, monitoring their status, updating parameters, and coordinating the behavior of the entire GNSS network. This is particularly useful for fleet management, allowing programmatic updates to keep configuration files in sync across all deployed boards.

In addition to the central system, each receiver also hosts a local web-based configuration interface. This configurator plays a crucial role, as it allows the setup of key parameters specific to each device — such as site name, caster credentials, approximate coordinates, and more. While the central system ensures coordination and consistency, the local interface ensures that each receiver can be individually tailored to its deployment context.


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

#### Important Note
The original LZER0 hardware was developed using the u-blox M8T receiver. However, this repository also includes designs for the LCC variant, based on the u-blox ZED-F9P, which supports multi-band GNSS and offers enhanced precision and performance.

### Manufacturing Your LZER0

1. **Download design files** from the `/hardware/` directory
2. **Source components** using the provided BOM
3. **Manufacture PCBs** using the Gerber files with your preferred fabricator
4. **Assemble hardware** following the assembly guide
5. **Test hardware** before software installation

### Hardware Variants


LZER0 supports multiple hardware configurations:

#### LZER0.moni 
Intended for permanent monitoring applications such as landslide or infrastructure observation. The unit is typically installed inside a solar-powered pillar with a panel, charge controller, and backup battery. It features the M8T receiver and Raspberry Pi connected via USB, and includes a built-in web server with real-time data visualization (e.g., NS/EW/UP displacements and interactive map).

#### LZER0.topo
A compact version designed for topographic and cadastral surveying. It uses a u-blox M8T GNSS receiver and a rechargeable LiPo battery, all housed in a 3D-printed enclosure with an integrated TW4721 antenna on a metallic support. The device connects wirelessly to an Android tablet, enabling real-time tracking of survey points and trajectories in the field.

#### LZER0.auto
Developed for automotive and dynamic positioning applications, such as agricultural machinery. The electronics (u-blox M8T, Raspberry Pi Zero W, and ATXraspi interface board) are enclosed in a rugged industrial-grade Gewiss GW44427 box. Powered by the vehicle's battery (24V to 5V converter), it connects to a tablet in the cabin, which provides NTRIP corrections and real-time guidance

#### LZER0-MOB
LZER0-MOB is a standalone GNSS device designed for temporary measurement campaigns and mobile deployments. It integrates a GNSS receiver (typically u-blox ZED-F9P), a Raspberry Pi, and a SIM-enabled communication module for remote data access.
Compact and easy to deploy, it is ideal for short-term geodetic or environmental monitoring. It can be powered by external batteries or solar panels, making it fully autonomous and suitable for fieldwork without permanent infrastructure.

#### LZER0-NET
LZER0-NET is designed for continuous operation in critical GNSS monitoring setups. It integrates a mini-UPS based on the PiJuice board, which ensures autonomous power backup during outages, safe shutdown, and reliable reboot.
Ideal for permanent installations, it combines a u-blox GNSS receiver with a Raspberry Pi, offering real-time data acquisition, onboard visualization, and remote access — making it a robust solution for long-term geodetic and environmental monitoring.



## 📄 Articles and informations available at:
- https://doi.org/10.3390/s22218314<br>
- https://doi.org/10.5194/egusphere-egu2020-9506<br>
- http://dx.doi.org/10.13140/RG.2.2.22750.05447<br>
- http://dx.doi.org/10.13140/RG.2.2.32319.61605<br>
- https://doi.org/10.3390/s22010350<br>
- https://hdl.handle.net/20.500.14083/43383<br>
