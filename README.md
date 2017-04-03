# FPGA hardware design for the Terasic DE10-Nano\* kit

## Overview
Instructions to build the FPGA design for the Terasic DE10-Nano\* Kit.

This repository provides support for building a demonstration FPGA image for the [Terasic DE10-Nano](https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&CategoryNo=205&No=1046&PartNo=8) kit's development board and is intended to be used in conjunction with the [meta-de10-nano](https://github.com/01org/meta-de10-nano) layer.

**Note:** RELEASE_BUILDS contains a generated project and all of the compiled output files.

**Note:** Only the release tags are tested fully.  The master branch is likely to work but is not thoroughly tested.

## Build Instructions
A Makefile based build is used for this project which results in the following outputs:

  * Compiled Intel\* Quartus\* Prime Design Software project
  * Generated Intel\* Quartus\* QSYS\* system
  * Generated and compiled devicetree overlay for the DE10-Nano\* Kit
  * Bootloader configuration files

**Note:** The RELEASE_BUILDS branch in this repository contains all of the above.

### Prerequisites:

  * Intel\* Quartus\* Prime Design Software Version 16.1.2
  * Intel\* SoCEDS\* Version 16.1

### Known Issues:
  * Intel\* QSYS\* build from tcl source may fail on systems without a full installation of the Intel\* Quartus\* Prime Design Software.  If you encounter this issue, please use a build from the RELEASE_BUILDS branch.

### Build from RELEASE_BUILDS branch:
The RELEASE_BUILDS branch has a complete Intel\* Quartus\* Prime Design Software project and associtated RTL and SDC scripts.  If you are familiar or prefer this flow, please refer to the Intel\* Quartus\* Prime Design documentation available [here](https://www.altera.com/products/design-software/fpga-design/quartus-prime/overview.html).

#### RELEASE_BUILDS contents:

  * **de0-nano:** Intel\* Quartus\* Prime Design project for the Terasic DE0-Nano-Soc kit (unsupported port)
      * **hps_isw_handoff**: prebuilt handoff files for the HPS
      * **output_files**: prebuild FPGA bitstream files (sof & rbf)
      * **preloader**: bsp-editor generated files for the HPS bootloader
  * **de10-nano**: Intel\* Quartus\* Prime Design project for the Terasic DE10-Nano kit
      * **hps_isw_handoff**: prebuilt handoff files for the HPS
      * **output_files**: prebuild FPGA bitstream files (sof & rbf)
      * **preloader**: bsp-editor generated files for the HPS bootloader
  * **devicetrees**: devicetree overlay source and devicetree overlay binaries for the kits
  * **hdl_src**: RTL and SDC source
  * **ip**: Custom Intel\* Quartus\* QSYS\* components
  * **patches**:  sopc2dts patches to add **BASIC** support for devicetree overlay generation

### Build:

**Note:**Under Development - will come soon




## Additional Resources
* [Discover the Terasic DE10-Nano Kit](https://signin.intel.com/logout?target=https://software.intel.com/en-us/iot/hardware/fpga/de10-nano)
* [Terasic DE10-Nano Get Started Guide](https://software.intel.com/en-us/terasic-de10-nano-get-started-guide)
* [Project: My First FPGA](https://software.intel.com/en-us/articles/my-first-fpga)
* [Learn more about Intel® FPGAs](https://software.intel.com/en-us/iot/hardware/fpga/)
