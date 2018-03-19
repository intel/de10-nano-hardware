# Copyright (c) 2016 Intel Corporation
# SPDX-License-Identifier: MIT

# exported interfaces
add_interface hps_0_i2c2 conduit end
set_interface_property hps_0_i2c2 EXPORT_OF hps_0.i2c2
add_interface hps_0_i2c2_clk clock source
set_interface_property hps_0_i2c2_clk EXPORT_OF hps_0.i2c2_clk
add_interface hps_0_i2c2_scl_in clock sink
set_interface_property hps_0_i2c2_scl_in EXPORT_OF hps_0.i2c2_scl_in
