//
// The MIT License (MIT)
// Copyright (c) 2016 Intel Corporation
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

module top 
#(
        parameter MEM_A_WIDTH,
        parameter MEM_D_WIDTH,
        parameter MEM_BA_WIDTH
)
(
    //Clocks and Resets
   input fpga_clk1_50,
   input fpga_clk2_50,         
   input fpga_clk3_50,

   // HPS memory controller ports
   output wire [MEM_A_WIDTH - 1:0]    hps_memory_mem_a,                           
   output wire [MEM_BA_WIDTH - 1:0]   hps_memory_mem_ba,                          
   output wire                        hps_memory_mem_ck,                          
   output wire                        hps_memory_mem_ck_n,                        
   output wire                        hps_memory_mem_cke,                         
   output wire                        hps_memory_mem_cs_n,                        
   output wire                        hps_memory_mem_ras_n,                       
   output wire                        hps_memory_mem_cas_n,                       
   output wire                        hps_memory_mem_we_n,                        
   output wire                        hps_memory_mem_reset_n,                     
   inout  wire [MEM_D_WIDTH - 1:0]    hps_memory_mem_dq,                          
   inout  wire [(MEM_D_WIDTH/8) -1:0] hps_memory_mem_dqs,                         
   inout  wire [(MEM_D_WIDTH/8) -1:0] hps_memory_mem_dqs_n,                       
   output wire                        hps_memory_mem_odt,                         
   output wire [(MEM_D_WIDTH/8) -1:0] hps_memory_mem_dm,                          
   input  wire                        hps_memory_oct_rzqin,                       
    // HPS peripherals
   output wire        hps_emac1_TX_CLK,   
   output wire        hps_emac1_TXD0,     
   output wire        hps_emac1_TXD1,     
   output wire        hps_emac1_TXD2,     
   output wire        hps_emac1_TXD3,     
   input  wire        hps_emac1_RXD0,     
   inout  wire        hps_emac1_MDIO,     
   output wire        hps_emac1_MDC,      
   input  wire        hps_emac1_RX_CTL,   
   output wire        hps_emac1_TX_CTL,   
   input  wire        hps_emac1_RX_CLK,   
   input  wire        hps_emac1_RXD1,     
   input  wire        hps_emac1_RXD2,     
   input  wire        hps_emac1_RXD3, 
   inout  wire        hps_sdio_CMD,       
   inout  wire        hps_sdio_D0,        
   inout  wire        hps_sdio_D1,        
   output wire        hps_sdio_CLK,       
   inout  wire        hps_sdio_D2,        
   inout  wire        hps_sdio_D3,        
   inout  wire        hps_usb1_D0,        
   inout  wire        hps_usb1_D1,        
   inout  wire        hps_usb1_D2,        
   inout  wire        hps_usb1_D3,        
   inout  wire        hps_usb1_D4,        
   inout  wire        hps_usb1_D5,        
   inout  wire        hps_usb1_D6,        
   inout  wire        hps_usb1_D7,        
   input  wire        hps_usb1_CLK,       
   output wire        hps_usb1_STP,       
   input  wire        hps_usb1_DIR,       
   input  wire        hps_usb1_NXT,       
   input  wire        hps_uart0_RX,       
   output wire        hps_uart0_TX,            
   output wire        hps_spim1_CLK,
   output wire        hps_spim1_MOSI,
   input  wire        hps_spim1_MISO,
   output wire        hps_spim1_SS0,
   inout  wire        hps_i2c0_SDA,
   inout  wire        hps_i2c0_SCL,
   inout  wire        hps_i2c1_SDA,
   inout  wire        hps_i2c1_SCL,
   inout  wire        hps_gpio_GPIO09,
   inout  wire        hps_gpio_GPIO35,
   inout  wire        hps_gpio_GPIO40,
   inout  wire        hps_gpio_GPIO53,
   inout  wire        hps_gpio_GPIO54,
   inout  wire        hps_gpio_GPIO61, // ADC IRQ 
   
    // FPGA GPIO
   input  wire [1:0]  fpga_key_pio,
   output wire [7:0]  fpga_led_pio,
   input  wire [3:0]  fpga_dipsw_pio,

    // ADC - LTC2308CUF 
   output  wire       adc_convst,
   output  wire       adc_sck,
   output  wire       adc_sdi,
   input   wire       adc_sdo,
   
    // Android IO    
   inout  wire [15:0] arduino_io,
   inout  wire        arduino_reset_n,

`ifdef DE10_NANO
   // HDMI
   inout wire         hdmi_i2c_scl,
   inout wire         hdmi_i2c_sda,
   inout wire         hdmi_i2s,
   inout wire         hdmi_lrclk,
   inout wire         hdmi_mclk,
   inout wire         hdmi_sclk,
   output wire        hdmi_tx_clk,
   output wire        hdmi_tx_de,
   output wire        hdmi_tx_hs,
   input wire         hdmi_tx_int,
   output wire        hdmi_tx_vs,
   output wire [23:0] hdmi_tx_d,
`endif

    // GPIO
      inout  wire [35:0] gpio_0,
      inout  wire [35:0] gpio_1   
);

//REG/WIRE Declarations
wire        hps_fpga_reset_n;
wire [27:0] stm_hw_events;

wire [1:0] fpga_debounced_buttons;
wire [7:0] fpga_led_internal;

//assignments
assign stm_hw_events = {{14{1'b0}}, fpga_dipsw_pio, fpga_led_internal, fpga_debounced_buttons};

assign arduino_reset_n = hps_fpga_reset_n;

assign fpga_led_pio = fpga_led_internal;

`ifdef DE10_NANO
// i2c connection
wire hdmi_internal_scl_o_e;
wire hdmi_internal_scl_o;
wire hdmi_internal_sda_o_e;
wire hdmi_internal_sda_o;

ALT_IOBUF scl_iobuf (.i(1'b0), .oe(hdmi_internal_scl_o_e), .o(hdmi_internal_scl_o), .io(hdmi_i2c_scl));
ALT_IOBUF sda_iobuf (.i(1'b0), .oe(hdmi_internal_sda_o_e), .o(hdmi_internal_sda_o), .io(hdmi_i2c_sda));
`endif  

// arduino i2c connection
wire arduino_internal_scl_o_e;
wire arduino_internal_scl_o;
wire arduino_internal_sda_o_e;
wire arduino_internal_sda_o;
wire arduino_hps_0_uart1_rxd;
wire arduino_hps_0_uart1_txd;
wire arduino_hps_0_spim0_ss_0_n;
wire arduino_hps_0_spim0_ssi_oe_n;
wire arduino_hps_0_spim0_ss_in_n;
wire arduino_hps_0_spim0_txd;
wire arduino_hps_0_spim0_rxd;
wire arduino_hps_0_spim0_sclk_out_clk;

ALT_IOBUF arduino_scl_iobuf (.i(1'b0), .oe(arduino_internal_scl_o_e), .o(arduino_internal_scl_o), .io(arduino_io[15]));
ALT_IOBUF arduino_sda_iobuf (.i(1'b0), .oe(arduino_internal_sda_o_e), .o(arduino_internal_sda_o), .io(arduino_io[14]));
 
//uart
ALT_IOBUF arduino_uart_rx_iobuf (.i(1'b0), .oe(1'b0), .o(arduino_hps_0_uart1_rxd), .io(arduino_io[0]));
ALT_IOBUF arduino_uart_tx_iobuf (.i(arduino_hps_0_uart1_txd), .oe(1'b1), .o(), .io(arduino_io[1]));
       
//spim                   
ALT_IOBUF arduino_ss_iobuf (.i(arduino_hps_0_spim0_ss_0_n), .oe(1'b1), .o(), .io(arduino_io[10]));
ALT_IOBUF arduino_mosi_iobuf (.i(arduino_hps_0_spim0_txd), .oe(1'b1), .o(), .io(arduino_io[11]));
ALT_IOBUF arduino_miso_iobuf (.i(1'b0), .oe(1'b0), .o(arduino_hps_0_spim0_rxd), .io(arduino_io[12]));
ALT_IOBUF arduino_sck_iobuf (.i(arduino_hps_0_spim0_sclk_out_clk), .oe(1'b1), .o(), .io(arduino_io[13]));

// SoC sub-system module
soc_system soc_inst (
  //Clocks & Resets
  .clk_clk                               (fpga_clk1_50),
  .hps_0_h2f_reset_reset_n               (hps_fpga_reset_n),
  
  //DRAM
  .memory_mem_a                          (hps_memory_mem_a),                               
  .memory_mem_ba                         (hps_memory_mem_ba),                         
  .memory_mem_ck                         (hps_memory_mem_ck),                         
  .memory_mem_ck_n                       (hps_memory_mem_ck_n),                       
  .memory_mem_cke                        (hps_memory_mem_cke),                        
  .memory_mem_cs_n                       (hps_memory_mem_cs_n),                       
  .memory_mem_ras_n                      (hps_memory_mem_ras_n),                      
  .memory_mem_cas_n                      (hps_memory_mem_cas_n),                      
  .memory_mem_we_n                       (hps_memory_mem_we_n),                       
  .memory_mem_reset_n                    (hps_memory_mem_reset_n),                    
  .memory_mem_dq                         (hps_memory_mem_dq),                         
  .memory_mem_dqs                        (hps_memory_mem_dqs),                        
  .memory_mem_dqs_n                      (hps_memory_mem_dqs_n),                      
  .memory_mem_odt                        (hps_memory_mem_odt),                            
  .memory_mem_dm                         (hps_memory_mem_dm),                         
  .memory_oct_rzqin                      (hps_memory_oct_rzqin),      
  
  //HPS Peripherals
  //Emac1
  .hps_0_hps_io_hps_io_emac1_inst_TX_CLK (hps_emac1_TX_CLK), 
  .hps_0_hps_io_hps_io_emac1_inst_TXD0   (hps_emac1_TXD0),   
  .hps_0_hps_io_hps_io_emac1_inst_TXD1   (hps_emac1_TXD1),   
  .hps_0_hps_io_hps_io_emac1_inst_TXD2   (hps_emac1_TXD2),   
  .hps_0_hps_io_hps_io_emac1_inst_TXD3   (hps_emac1_TXD3),   
  .hps_0_hps_io_hps_io_emac1_inst_RXD0   (hps_emac1_RXD0),   
  .hps_0_hps_io_hps_io_emac1_inst_MDIO   (hps_emac1_MDIO),   
  .hps_0_hps_io_hps_io_emac1_inst_MDC    (hps_emac1_MDC),    
  .hps_0_hps_io_hps_io_emac1_inst_RX_CTL (hps_emac1_RX_CTL), 
  .hps_0_hps_io_hps_io_emac1_inst_TX_CTL (hps_emac1_TX_CTL), 
  .hps_0_hps_io_hps_io_emac1_inst_RX_CLK (hps_emac1_RX_CLK), 
  .hps_0_hps_io_hps_io_emac1_inst_RXD1   (hps_emac1_RXD1),   
  .hps_0_hps_io_hps_io_emac1_inst_RXD2   (hps_emac1_RXD2),   
  .hps_0_hps_io_hps_io_emac1_inst_RXD3   (hps_emac1_RXD3),
  //SDMMC
  .hps_0_hps_io_hps_io_sdio_inst_CMD     (hps_sdio_CMD),     
  .hps_0_hps_io_hps_io_sdio_inst_D0      (hps_sdio_D0),      
  .hps_0_hps_io_hps_io_sdio_inst_D1      (hps_sdio_D1),      
  .hps_0_hps_io_hps_io_sdio_inst_CLK     (hps_sdio_CLK),     
  .hps_0_hps_io_hps_io_sdio_inst_D2      (hps_sdio_D2),      
  .hps_0_hps_io_hps_io_sdio_inst_D3      (hps_sdio_D3),
  //USB1
  .hps_0_hps_io_hps_io_usb1_inst_D0      (hps_usb1_D0),      
  .hps_0_hps_io_hps_io_usb1_inst_D1      (hps_usb1_D1),      
  .hps_0_hps_io_hps_io_usb1_inst_D2      (hps_usb1_D2),      
  .hps_0_hps_io_hps_io_usb1_inst_D3      (hps_usb1_D3),      
  .hps_0_hps_io_hps_io_usb1_inst_D4      (hps_usb1_D4),      
  .hps_0_hps_io_hps_io_usb1_inst_D5      (hps_usb1_D5),      
  .hps_0_hps_io_hps_io_usb1_inst_D6      (hps_usb1_D6),      
  .hps_0_hps_io_hps_io_usb1_inst_D7      (hps_usb1_D7),      
  .hps_0_hps_io_hps_io_usb1_inst_CLK     (hps_usb1_CLK),     
  .hps_0_hps_io_hps_io_usb1_inst_STP     (hps_usb1_STP),     
  .hps_0_hps_io_hps_io_usb1_inst_DIR     (hps_usb1_DIR),     
  .hps_0_hps_io_hps_io_usb1_inst_NXT     (hps_usb1_NXT),
  //UART0
  .hps_0_hps_io_hps_io_uart0_inst_RX     (hps_uart0_RX),     
  .hps_0_hps_io_hps_io_uart0_inst_TX     (hps_uart0_TX),     
  //SPIM1
  .hps_0_hps_io_hps_io_spim1_inst_CLK    (hps_spim1_CLK),
  .hps_0_hps_io_hps_io_spim1_inst_MOSI   (hps_spim1_MOSI),
  .hps_0_hps_io_hps_io_spim1_inst_MISO   (hps_spim1_MISO),
  .hps_0_hps_io_hps_io_spim1_inst_SS0    (hps_spim1_SS0),
  //I2C 0,1
  .hps_0_hps_io_hps_io_i2c0_inst_SDA     (hps_i2c0_SDA),
  .hps_0_hps_io_hps_io_i2c0_inst_SCL     (hps_i2c0_SCL),
  .hps_0_hps_io_hps_io_i2c1_inst_SDA     (hps_i2c1_SDA),
  .hps_0_hps_io_hps_io_i2c1_inst_SCL     (hps_i2c1_SCL),
  //GPIO
  .hps_0_hps_io_hps_io_gpio_inst_GPIO09  (hps_gpio_GPIO09),
  .hps_0_hps_io_hps_io_gpio_inst_GPIO35  (hps_gpio_GPIO35),
  .hps_0_hps_io_hps_io_gpio_inst_GPIO40  (hps_gpio_GPIO40),
  .hps_0_hps_io_hps_io_gpio_inst_GPIO53  (hps_gpio_GPIO53),
  .hps_0_hps_io_hps_io_gpio_inst_GPIO54  (hps_gpio_GPIO54),
  .hps_0_hps_io_hps_io_gpio_inst_GPIO61  (hps_gpio_GPIO61), 
  
  //STM
  .hps_0_f2h_stm_hw_events_stm_hwevents  (stm_hw_events),  

`ifdef DE10_NANO
  //HDMI
  .clk_hdmi_clk                                      (hdmi_tx_clk),
  .alt_vip_cl_cvo_hdmi_clocked_video_vid_clk         (hdmi_tx_clk),
  .alt_vip_cl_cvo_hdmi_clocked_video_vid_data        (hdmi_tx_d),
  .alt_vip_cl_cvo_hdmi_clocked_video_underflow       (),
  .alt_vip_cl_cvo_hdmi_clocked_video_vid_mode_change (),
  .alt_vip_cl_cvo_hdmi_clocked_video_vid_std         (),
  .alt_vip_cl_cvo_hdmi_clocked_video_vid_datavalid   (hdmi_tx_de),
  .alt_vip_cl_cvo_hdmi_clocked_video_vid_v_sync      (hdmi_tx_vs),
  .alt_vip_cl_cvo_hdmi_clocked_video_vid_h_sync      (hdmi_tx_hs),
  .alt_vip_cl_cvo_hdmi_clocked_video_vid_f           (),
  .alt_vip_cl_cvo_hdmi_clocked_video_vid_h           (),
  .alt_vip_cl_cvo_hdmi_clocked_video_vid_v           (),

  //HDMI I2C
  .hps_0_i2c2_out_data   (hdmi_internal_sda_o_e),
  .hps_0_i2c2_sda        (hdmi_internal_sda_o),
  .hps_0_i2c2_clk_clk    (hdmi_internal_scl_o_e),
  .hps_0_i2c2_scl_in_clk (hdmi_internal_scl_o),

`endif

  //Arduino
  .hps_0_spim0_txd          (arduino_hps_0_spim0_txd),
  .hps_0_spim0_rxd          (arduino_hps_0_spim0_rxd),
  .hps_0_spim0_ss_in_n      (1'b1),
  .hps_0_spim0_ssi_oe_n     (arduino_hps_0_spim0_ssi_oe_n),
  .hps_0_spim0_ss_0_n       (arduino_hps_0_spim0_ss_0_n),
  .hps_0_spim0_ss_1_n       (),
  .hps_0_spim0_ss_2_n       (),
  .hps_0_spim0_ss_3_n       (),
  .hps_0_spim0_sclk_out_clk (arduino_hps_0_spim0_sclk_out_clk),
  .hps_0_uart1_cts          (),
  .hps_0_uart1_dsr          (),
  .hps_0_uart1_dcd          (),
  .hps_0_uart1_ri           (),
  .hps_0_uart1_dtr          (),
  .hps_0_uart1_rts          (),
  .hps_0_uart1_out1_n       (),
  .hps_0_uart1_out2_n       (),
  .hps_0_uart1_rxd          (arduino_hps_0_uart1_rxd),
  .hps_0_uart1_txd          (arduino_hps_0_uart1_txd),
  .hps_0_i2c3_scl_in_clk    (arduino_internal_scl_o),
  .hps_0_i2c3_clk_clk       (arduino_internal_scl_o_e),
  .hps_0_i2c3_out_data      (arduino_internal_sda_o_e),
  .hps_0_i2c3_sda           (arduino_internal_sda_o),
  .arduino_gpio_export      (arduino_io[9:2]),

  //Header GPIOs
  .gpio_0_a_export          (gpio_0[17:0]),
  .gpio_0_b_export          (gpio_0[35:18]),
  .gpio_1_a_export          (gpio_1[17:0]),
  .gpio_1_b_export          (gpio_1[35:18]),
  
  //PIOs
  .button_pio_export        (fpga_debounced_buttons),
  .dipsw_pio_export         (fpga_dipsw_pio),
  .led_pio_export           (fpga_led_internal)
);  


// Debounce logic to clean out glitches within 1ms
debounce debounce_inst (
  .clk                                  (fpga_clk1_50),
  .reset_n                              (hps_fpga_reset_n),  
  .data_in                              (fpga_key_pio),
  .data_out                             (fpga_debounced_buttons)
);
  defparam debounce_inst.WIDTH = 2;
  defparam debounce_inst.POLARITY = "LOW";
  defparam debounce_inst.TIMEOUT = 50000;               // at 50Mhz this is a debounce time of 1ms
  defparam debounce_inst.TIMEOUT_WIDTH = 16;            // ceil(log2(TIMEOUT))

endmodule
