# FPGA hardware design for the Terasic DE10-Nano\* kit

## Overview
Instructions to build the FPGA design for the Terasic DE10-Nano\* Kit.

This repository provides support for building a demonstration FPGA image for the [Terasic DE10-Nano](https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&CategoryNo=205&No=1046&PartNo=8) kit's development board and is intended to be used in conjunction with the [meta-de10-nano](https://github.com/01org/meta-de10-nano) layer.

There are 3 FPGA projects created during the build
  * **de10-nano-base**:  A base design with no IP requiring additional licenses
  * **de10-nano-fft**:  An FPGA based FFT example.  The FFT IP does require a license
  * **de10-nano-mandelbrot**:  An FPGA implementation of a Mandelbrot.  The output of the Mandelbrot is displayed on the HDMI output

**Note:** Released builds of the FPGA images are available in the release section of the github project.

**Note:** Only the release builds are tested fully.  The master branch is likely to work but is not thoroughly tested.

## Build Instructions
A Makefile based build is used for this project which results in the following outputs:

  * Compiled Intel\* Quartus\* Prime Design Software project
  * Generated Intel\* Quartus\* QSYS\* system
  * Generated and compiled devicetree overlay for the DE10-Nano\* Kit
  * Bootloader configuration files

**Note:** The release build tar file contains all FPGA programing files as well all of the above mentioned files.

### Prerequisites:

  * Intel\* Quartus\* Prime Design Software Version 17.1.2
  * Intel\* SoCEDS\* Version 17.1

### Known Issues:
  * Intel\* QSYS\* build from tcl source may fail on systems without a full installation of the Intel\* Quartus\* Prime Design Software.  If you encounter this issue, please use a build from one of the released tar.gz files available in the releases section.

### Build from a release archive:
The release archive has a complete Intel\* Quartus\* Prime Design Software project and associtated RTL and SDC scripts.  If you are familiar or prefer this flow, please refer to the Intel\* Quartus\* Prime Design documentation available [here](https://www.altera.com/products/design-software/fpga-design/quartus-prime/overview.html).

#### Release archive contents:

  * **de10-nano-base**: Intel\* Quartus\* Prime Design project for the Terasic DE10-Nano kit
      * **hps_isw_handoff**: prebuilt handoff files for the HPS
      * **output_files**: prebuild FPGA bitstream files (sof & rbf)
      * **preloader**: bsp-editor generated files for the HPS bootloader
  * **de10-nano-fft**: Intel\* Quartus\* Prime Design project for the Terasic DE10-Nano kit
      * **hps_isw_handoff**: prebuilt handoff files for the HPS
      * **output_files**: prebuild FPGA bitstream files (sof & rbf)
      * **preloader**: bsp-editor generated files for the HPS bootloader
  * **de10-nano-mandelbrot**: Intel\* Quartus\* Prime Design project for the Terasic DE10-Nano kit
      * **hps_isw_handoff**: prebuilt handoff files for the HPS
      * **output_files**: prebuild FPGA bitstream files (sof & rbf)
      * **preloader**: bsp-editor generated files for the HPS bootloader
  * **devicetrees**: devicetree overlay source and devicetree overlay binaries for the kits
  * **hdl_src**: RTL and SDC source
  * **ip**: Custom Intel\* Quartus\* QSYS\* components
  * **patches**:  sopc2dts patches to add **BASIC** support for devicetree overlay generation
  * **Makefile**:  Main Makefile for building the Terasic\* DE10-Nano-SoC projects
  * **mks**:  Makefile fragments for various build outputs of the project.  These are included in the main Makefile

### Build from release archives:

For building the projects from the generated Intel\* Quartus\* Prime Design project and generated Intel\* Quartus\* QSYS\* system please read the design tools documentation.

### Build from GIT:

The build has only been tested on a linux host, although there are no known reasons this will not work in a Cygwin shell.

Please refer to 'make help' for all build targets, to build everything, simple make all.

  * Clone the repository: git clone https://github.com/intel/de10-nano-hardware.git
  * cd de10-nano-hardware
  * Ensure that you have the tools listed in the prerequisits in your path!
  * make all

### Preloader and u-Boot generation

This example uses mainline u-Boot for the Intel\* Cyclone5\* FPGA.  The repository for this is available [here](http://git.denx.de/?p=u-boot.git;a=summary).  The build requires the bsp-editor preloader output created by the Intel\* SoCEDS\* tools.  Please follow the [readme](http://git.denx.de/?p=u-boot.git;a=blob_plain;f=doc/README.socfpga;hb=HEAD) available in the repository for generation and creation of the appropriate files should you want to build it yourself.  Please note that the linux build for the Terasic\* DE10-Nano-SoC does also build the bootloader.

## Additional Resources
* [Discover the Terasic DE10-Nano Kit](https://signin.intel.com/logout?target=https://software.intel.com/en-us/iot/hardware/fpga/de10-nano)
* [Terasic DE10-Nano Get Started Guide](https://software.intel.com/en-us/terasic-de10-nano-get-started-guide)
* [Project: My First FPGA](https://software.intel.com/en-us/articles/my-first-fpga)
* [Learn more about Intel® FPGAs](https://software.intel.com/en-us/iot/hardware/fpga/)
