# LZER0
LZER0: a cost-effective multi-purpose GNSS platform (Hardware and Software).<br>
![image](/Images/lzer0.full.png)
<br>

## Software
software to manage the different parts of the LZER0 system are available at differente repositories

### Software for the basic operation of the LZER0 receiver

#### HOME/BIN LZER0
Contains scripts, tools, and utility software necessary for the daily operation of the LZER0 receiver.
It includes tools for starting services, managing GNSS files, communicating with peripherals, and other
system operations. It is the central component that defines the behavior of the device once it is powered on.

https://github.com/OGS-GNSS/homebin_lzer0

#### HOME/CFG LZER0
Contains examples of the configuration file related to the operation of the LZER0 receiver. Some files are used directly,
others are dynamically regenerated at provisioning or boot time.

https://github.com/OGS-GNSS/homecfg_lzer0 

### WEB based configuration system

#### GNSS Central Config
Web interface for centralized management of a pool of LZER0 receivers. It allows you to define and distribute device
configurations, monitor their status, update parameters, and coordinate the behavior of the entire GNSS network.

https://hub.geosciences-ir.it/git/geosciencesir-devop/ogs_dev/gnss-central-config (it will be public soon)

### Deployment system

#### LZER0 provisioning
Main repository for the automatic deployment and provisioning of lzer0 devices. It manages the entire device
lifecycle: from initial power-up to final configuration. Includes scripts for installation, cloning of the required
repositories, and network and service setup.

https://hub.geosciences.cloud/git/geosciencesir-devop/ogs_dev/lzer0_provisioning (it will be public soon)

#### Assets to be configured
Contains the customizable assets needed to adapt the provisioning system to your operating environment. This
repository is automatically cloned by the provisioning system.

https://github.com/OGS-GNSS/lzer0_generic_assets

## Articles and informations available at:
- https://doi.org/10.3390/s22218314<br>
- https://doi.org/10.5194/egusphere-egu2020-9506<br>
- http://dx.doi.org/10.13140/RG.2.2.22750.05447<br>
- http://dx.doi.org/10.13140/RG.2.2.32319.61605<br>
- https://doi.org/10.3390/s22010350<br>
