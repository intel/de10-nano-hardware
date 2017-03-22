module reset_sync_block (
  clk_in,
  reset_in,
  clk_out,
  reset_out
);

  parameter SYNC_DEPTH = 3;               // needs to be at least two but on new FPGAs should be at least 3
  parameter ADDITIONAL_DEPTH = 2;         // needs to be at least two stages, increase this if recovery errors occur even with DISABLE_GLOBAL_NETWORK is set to 1
  parameter DISABLE_GLOBAL_NETWORK = 1;   // set to 1 to prevent synchronized reset from getting promoted to global network, enable this if recovery errors occur from FFs hooked up to reset_out
  parameter SYNC_BOTH_EDGES = 0;          // set to 1 synchronize the reset_in to both edges, set to 0 to allow reset_out to deassert asynchronously and assert synchronously
  
  input clk_in;
  input reset_in;
  output wire clk_out;
  output wire reset_out;
  
  wire synchronized_reset;
  


generate 
  if (SYNC_BOTH_EDGES == 0)  // use reset_in as an asynchronous clear for reset_out but sychronize reset_out to the rising clock edge
  begin

    deassert_synchronizer the_deassert_synchronizer(
      .clk         (clk_in),
      .reset_in    (reset_in),
      .reset_out   (synchronized_reset)
    );
    defparam the_deassert_synchronizer.SYNC_DEPTH = SYNC_DEPTH;
    defparam the_deassert_synchronizer.ADDITIONAL_DEPTH = ADDITIONAL_DEPTH;
    defparam the_deassert_synchronizer.DISABLE_GLOBAL_NETWORK = DISABLE_GLOBAL_NETWORK;

    
  end
  else  // just synchronize and pipeline reset_in and feed it back out as reset_out
  begin

    both_synchronizer the_both_synchronizer(
      .clk         (clk_in),
      .reset_in    (reset_in),
      .reset_out   (synchronized_reset)
    );
    defparam the_both_synchronizer.SYNC_DEPTH = SYNC_DEPTH;
    defparam the_both_synchronizer.ADDITIONAL_DEPTH = ADDITIONAL_DEPTH;
    defparam the_both_synchronizer.DISABLE_GLOBAL_NETWORK = DISABLE_GLOBAL_NETWORK;
    
  end
endgenerate

  
  assign clk_out = clk_in;   // this signal is included to make it easier to export a clock and reset to the level above it
  assign reset_out = synchronized_reset;
  
endmodule




module deassert_synchronizer (
  clk,
  reset_in,
  reset_out
);
  parameter SYNC_DEPTH = 3;
  parameter ADDITIONAL_DEPTH = 2;
  parameter DISABLE_GLOBAL_NETWORK = 1;
  
  input clk;
  input reset_in;
  output wire reset_out;
  
  (* preserve *) reg [SYNC_DEPTH-1 : 0] synchronizer_reg;

  
  // shifting the 0 from the MSB down to the LSB, this will make keeping things off the global network much easier
  always @ (posedge clk or posedge reset_in)
  begin
    if (reset_in == 1'b1)
    begin
      synchronizer_reg <= {SYNC_DEPTH {1'b1}};
    end
    else
    begin
      synchronizer_reg[SYNC_DEPTH-1] <= 1'b0;
      synchronizer_reg[SYNC_DEPTH-2:0] <= synchronizer_reg[SYNC_DEPTH-1:1];  // right shift by 1
    end
  end

  // need to keep the declaration of output_pipeline_reg in the same scope as the driving of reset_out
  generate
  if (DISABLE_GLOBAL_NETWORK == 0) 
  begin
    reg [ADDITIONAL_DEPTH-1:0] output_pipeline_reg;

    // using the LSB output of the synchronizer as the asynchronous reset of the output pipeline
    always @ (posedge clk or posedge synchronizer_reg[0])
    begin
      if (synchronizer_reg[0] == 1'b1)
      begin
        output_pipeline_reg <= {ADDITIONAL_DEPTH {1'b1}};
      end
      else
      begin
        output_pipeline_reg[ADDITIONAL_DEPTH-1] <= 1'b0;   // feeding the synchronizer output into this pipeline's MSB
        output_pipeline_reg[ADDITIONAL_DEPTH-2:0] <= output_pipeline_reg[ADDITIONAL_DEPTH-1:1];  // right shift by 1
      end
    end

    assign reset_out = output_pipeline_reg[0];
  end
  else
  begin
    (* altera_attribute = "-name GLOBAL_SIGNAL OFF" *) reg [ADDITIONAL_DEPTH-1:0] output_pipeline_reg;

    // using the LSB output of the synchronizer as the asynchronous reset of the output pipeline
    always @ (posedge clk or posedge synchronizer_reg[0])
    begin
      if (synchronizer_reg[0] == 1'b1)
      begin
        output_pipeline_reg <= {ADDITIONAL_DEPTH {1'b1}};
      end
      else
      begin
        output_pipeline_reg[ADDITIONAL_DEPTH-1] <= 1'b0;   // feeding the synchronizer output into this pipeline's MSB
        output_pipeline_reg[ADDITIONAL_DEPTH-2:0] <= output_pipeline_reg[ADDITIONAL_DEPTH-1:1];  // right shift by 1
      end
    end

    assign reset_out = output_pipeline_reg[0];
  end
  endgenerate


  
endmodule


module both_synchronizer (
  clk,
  reset_in,
  reset_out
);

  parameter SYNC_DEPTH = 3;
  parameter ADDITIONAL_DEPTH = 2;
  parameter DISABLE_GLOBAL_NETWORK = 1;
  
  input clk;
  input reset_in;
  output wire reset_out;
  
  (* preserve *) reg [SYNC_DEPTH-1 : 0] synchronizer_reg;


  always @ (posedge clk or posedge reset_in)
  begin
    if (reset_in == 1'b1)
    begin
      synchronizer_reg <= {SYNC_DEPTH {1'b1}};
    end
    else
    begin
      synchronizer_reg[SYNC_DEPTH-1] <= 1'b0;
      synchronizer_reg[SYNC_DEPTH-2:0] <= synchronizer_reg[SYNC_DEPTH-1:1];  // right shift by 1
    end
  end
  
  // need to keep the declaration of output_pipeline_reg in the same scope as the driving of reset_out
  generate
  if (DISABLE_GLOBAL_NETWORK == 0)
  begin  
    reg [ADDITIONAL_DEPTH-1:0] output_pipeline_reg;

    always @ (posedge clk)
    begin
      output_pipeline_reg[ADDITIONAL_DEPTH-1] <= synchronizer_reg[0];   // feeding the synchronizer output into this pipeline's MSB
      output_pipeline_reg[ADDITIONAL_DEPTH-2:0] <= output_pipeline_reg[ADDITIONAL_DEPTH-1:1];  // right shift by 1
    end
    
    assign reset_out = output_pipeline_reg[0];
  end
  else
  begin
    (* altera_attribute = "-name GLOBAL_SIGNAL OFF" *) reg [ADDITIONAL_DEPTH-1:0] output_pipeline_reg;

    always @ (posedge clk)
    begin
      output_pipeline_reg[ADDITIONAL_DEPTH-1] <= synchronizer_reg[0];   // feeding the synchronizer output into this pipeline's MSB
      output_pipeline_reg[ADDITIONAL_DEPTH-2:0] <= output_pipeline_reg[ADDITIONAL_DEPTH-1:1];  // right shift by 1
    end
    
    assign reset_out = output_pipeline_reg[0];
  end
  endgenerate

  
endmodule
