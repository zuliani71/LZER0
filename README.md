# LZER0
![image](/Images/lzer0.full.png)

LZER0: a cost-effective multi-purpose GNSS platform (Hardware and Software) developed by OGS for seismic and geophysical monitoring.

## 🔍 Overview
- 📇 Based on u‑blox M8T GNSS receiver + Raspberry Pi Zero W.
- 🧰 Processes data with RTKLIB (real-time RTK/PPK).
- 🖥️ Includes Bash scripts, Ansible provisioning, and web interface for fleet management :contentReference[oaicite:1]{index=1}.

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


## 📄 Articles and informations available at:
- https://doi.org/10.3390/s22218314<br>
- https://doi.org/10.5194/egusphere-egu2020-9506<br>
- http://dx.doi.org/10.13140/RG.2.2.22750.05447<br>
- http://dx.doi.org/10.13140/RG.2.2.32319.61605<br>
- https://doi.org/10.3390/s22010350<br>
