# Copyright (c) 2016 Intel Corporation
# SPDX-License-Identifier: MIT

package provide adc_toolkit 0.1
package require Tcl 8.5
puts [pwd]
  #load the fpga
#set device_index 0 ; #Device index for target usually this is 0
#set device [lindex [get_service_paths device] $device_index]
  # this assume that sytem-console was launched within the quartus project directory
#set sof_path soc_system.sof
#device_download_sof $device $sof_path


puts [set m [lindex [ get_service_paths master ] 0]]
#set a bunch of defines so we can easily change them.
set SGDMA_TO_FFT_CSR_BASE  0x80000
set SGDMA_TO_FFT_DESCRIPTOR_SLAVE_BASE  0x90000
set SGDMA_FROM_FFT_CSR_BASE  0xA0000
set SGDMA_FROM_FFT_DESCRIPTOR_SLAVE_BASE 0xB0000
set DATA_BASE 0xC0000
set RESULT_BASE 0xC8000
set FFT_CSR 0xD0000
#set SGDMA_TO_FFT_CSR_BASE  0x100000
#set SGDMA_TO_FFT_DESCRIPTOR_SLAVE_BASE  0x110000
#set SGDMA_FROM_FFT_CSR_BASE  0x120000
#set SGDMA_FROM_FFT_DESCRIPTOR_SLAVE_BASE 0x130000
#set DATA_BASE 0x140000
#set RESULT_BASE 0x148000
#set FFT_CSR 0x150000

set DMA_DATA_BASE 0x40000
set DMA_RESULT_BASE 0x48000
set sample_size 128
set sample_list { 128 256 512 1024 2048 4096}
set triangle_list { 0 256 512 768 1024 1280 1536 1792 2048 1792 1536 1280 1024 768 512 256 0 -256 -512 -768 -1024 -1280 -1536 -1792 -2048 -1792 -1536 -1280 -1024 -768 -512 -256 }
open_service master $m

#create the dash board
set dash [ add_service dashboard demo "FFT demo" "Tools/FFT Demo" ]

# Make it appear
dashboard_set_property $dash self itemsPerRow 1
dashboard_set_property $dash self visible true

	#create calculator ADC channel Selector
dashboard_add $dash FFT_LengthLabel label self
dashboard_set_property $dash FFT_LengthLabel text "<html><font><b>FFT Length:</b></font></html>"
dashboard_add $dash FFT_LengthComboBox comboBox self 
dashboard_set_property $dash FFT_LengthComboBox options $sample_list
dashboard_set_property $dash FFT_LengthComboBox minWidth 80
dashboard_set_property $dash FFT_LengthComboBox onChange {set_sample_size [dashboard_get_property $dash FFT_LengthComboBox selected]}

dashboard_add $dash b0 button self
dashboard_set_property $dash b0 text "square Wave"
dashboard_set_property $dash b0 preferredWidth 100
dashboard_set_property $dash b0 onClick [list fft_wave 0]

dashboard_add $dash b1 button self
dashboard_set_property $dash b1 text "Sine Wave"
dashboard_set_property $dash b1 preferredWidth 100
dashboard_set_property $dash b1 onClick [list fft_wave 1]

dashboard_add $dash b2 button self
dashboard_set_property $dash b2 text "Sawtooth Wave"
dashboard_set_property $dash b2 preferredWidth 100
dashboard_set_property $dash b2 onClick [list fft_wave 2]


  dashboard_add $dash scopeBottomGroup tabbedGroup self 
  dashboard_set_property $dash scopeBottomGroup expandableX true 
  dashboard_set_property $dash scopeBottomGroup expandableY true
  
  dashboard_add $dash scopeGraphTab group scopeBottomGroup 
  dashboard_set_property $dash scopeGraphTab expandableX true 
  dashboard_set_property $dash scopeGraphTab expandableY true
  dashboard_set_property $dash scopeGraphTab title "Waveforms"
  
  dashboard_add $dash scopeRawTab group scopeBottomGroup 
  dashboard_set_property $dash scopeRawTab expandableX true 
  dashboard_set_property $dash scopeRawTab expandableY true
  dashboard_set_property $dash scopeRawTab title "Input Raw Data"
  
  dashboard_add  $dash scopeChart xyChart scopeGraphTab 
 dashboard_set_property $dash scopeChart expandableX true 
  dashboard_set_property $dash scopeChart expandableY true
  dashboard_set_property $dash scopeChart title "Input"
  dashboard_set_property $dash scopeChart labelX "Sample #"
  dashboard_set_property $dash scopeChart labelY "Mag"
  dashboard_set_property $dash scopeChart maximumItemCount $sample_size
		
		#insert scoperaw data table in
  dashboard_add  $dash scopeRawDataTable table scopeRawTab 
  dashboard_set_property $dash scopeRawDataTable expandableY true
  dashboard_set_property  $dash scopeRawDataTable columnHeaders {"Sample #" "Code" "waveform"}
  dashboard_set_property  $dash scopeRawDataTable rowSorterEnabled 1
  dashboard_set_property  $dash scopeRawDataTable columnIndex 0
  dashboard_set_property  $dash scopeRawDataTable columnRowSorterType int
  dashboard_set_property  $dash scopeRawDataTable columnIndex 1
  dashboard_set_property  $dash scopeRawDataTable columnRowSorterType int
  dashboard_set_property  $dash scopeRawDataTable showExportCsv 1

    dashboard_add  $dash scopeChart_r xyChart scopeGraphTab 
 dashboard_set_property $dash scopeChart_r expandableX true 
  dashboard_set_property $dash scopeChart_r expandableY true
  dashboard_set_property $dash scopeChart_r title "Real"
  dashboard_set_property $dash scopeChart_r labelX "Sample #"
  dashboard_set_property $dash scopeChart_r labelY "Mag"
  dashboard_set_property $dash scopeChart_r maximumItemCount $sample_size
		
		#insert scoperaw data table in
  dashboard_add  $dash scopeRawDataTable_r table scopeRawTab 
  dashboard_set_property $dash scopeRawDataTable_r expandableY true
  dashboard_set_property  $dash scopeRawDataTable_r columnHeaders {"Sample #" "Code" "real fft"}
  dashboard_set_property  $dash scopeRawDataTable_r rowSorterEnabled 1
  dashboard_set_property  $dash scopeRawDataTable_r columnIndex 0
  dashboard_set_property  $dash scopeRawDataTable_r columnRowSorterType int
  dashboard_set_property  $dash scopeRawDataTable_r columnIndex 1
  dashboard_set_property  $dash scopeRawDataTable_r columnRowSorterType int
  dashboard_set_property  $dash scopeRawDataTable_r showExportCsv 1
  
    dashboard_add  $dash scopeChart_i xyChart scopeGraphTab 
 dashboard_set_property $dash scopeChart_i expandableX true 
  dashboard_set_property $dash scopeChart_i expandableY true
  dashboard_set_property $dash scopeChart_i title "Imaginary"
  dashboard_set_property $dash scopeChart_i labelX "Sample #"
  dashboard_set_property $dash scopeChart_i labelY "Mag"
  dashboard_set_property $dash scopeChart_i maximumItemCount $sample_size
		
		#insert scoperaw data table in
  dashboard_add  $dash scopeRawDataTable_i table scopeRawTab 
  dashboard_set_property $dash scopeRawDataTable_i expandableY true
  dashboard_set_property  $dash scopeRawDataTable_i columnHeaders {"Sample #" "Code" "imag fft"}
  dashboard_set_property  $dash scopeRawDataTable_i rowSorterEnabled 1
  dashboard_set_property  $dash scopeRawDataTable_i columnIndex 0
  dashboard_set_property  $dash scopeRawDataTable_i columnRowSorterType int
  dashboard_set_property  $dash scopeRawDataTable_i columnIndex 1
  dashboard_set_property  $dash scopeRawDataTable_i columnRowSorterType int
  dashboard_set_property  $dash scopeRawDataTable_i showExportCsv 1


proc fft_wave {  waveform } {
	global SGDMA_TO_FFT_CSR_BASE  
	global SGDMA_TO_FFT_DESCRIPTOR_SLAVE_BASE  
	global SGDMA_FROM_FFT_CSR_BASE 
	global SGDMA_FROM_FFT_DESCRIPTOR_SLAVE_BASE 
	global DATA_BASE 
	global RESULT_BASE 
	global sample_size 
	global DMA_DATA_BASE
        global DMA_RESULT_BASE 
        global FFT_CSR
	global m
	global dash
	global triangle_list
	set index 0
	set graph_data "Signal"
	set graph_data_r "Real"
	set graph_data_i "Imaginary"

	
	#need to force a reset through the master incase something bad has happened before this point
#	jtag_debug_reset_system $m
	# set the number of samples
	#reset the sgdma
#	master_write_32 $m $SGDMA_TO_FFT_CSR_BASE 64
#        master_write_32 $m $SGDMA_FROM_FFT_CSR_BASE 64
	dashboard_set_property $dash scopeChart maximumItemCount $sample_size
	dashboard_set_property $dash scopeChart_r maximumItemCount $sample_size
	dashboard_set_property $dash scopeChart_i maximumItemCount $sample_size
	master_write_32 $m $FFT_CSR $sample_size
	puts "sample length"
	puts [master_read_32 $m $FFT_CSR 1]
# we will be only loading the real portion of the wave form which is the upper 16 bits of the 32 bits. 	
	set temp 0
	for {set i 0} {$i < $sample_size} {incr i} {
	  if {$waveform==0} {
# make small spikes  should give a sinx/x wave form. if I remember my DSP well
	    set temp [expr (((($i%32)<16) * 0xffff) - 0x8000) & 0xffff] 
	  }
	  if {$waveform==1} {
	    set temp [ expr  int((( sin(2.0*3.1415* $i/16.0)*0x7fff))) & 0xffff ]
	  }
#	  master_write_32 $m [expr ($DATA_BASE + ($i * 4)) ] $temp
	  
	  if {$waveform==2} {
	    set value [lindex $triangle_list [expr $i % 32]]
	    set temp [ expr  ($value * 15)& 0xffff ]
	  }
	  master_write_32 $m [expr $DATA_BASE + ($i * 4)] $temp
	}
# zero out the second half of the on chip memory	         
	for {set i 0} {$i < [expr $sample_size*2]} {incr i} {
	  master_write_32 $m [expr $RESULT_BASE + ($i * 4)] 0
	}


#load the sgdmas up
      master_write_32 $m [expr $SGDMA_TO_FFT_DESCRIPTOR_SLAVE_BASE + 0 ] $DMA_DATA_BASE
      master_write_32 $m [expr $SGDMA_TO_FFT_DESCRIPTOR_SLAVE_BASE + 4 ] 0
      master_write_32 $m [expr $SGDMA_TO_FFT_DESCRIPTOR_SLAVE_BASE + 8 ] [expr $sample_size *4 ]
      master_write_32 $m [expr $SGDMA_TO_FFT_DESCRIPTOR_SLAVE_BASE + 0xc ] 0x80000300
      

      master_write_32 $m [expr $SGDMA_FROM_FFT_DESCRIPTOR_SLAVE_BASE + 0 ] 0
      master_write_32 $m [expr $SGDMA_FROM_FFT_DESCRIPTOR_SLAVE_BASE + 4 ] $DMA_RESULT_BASE
      master_write_32 $m [expr $SGDMA_FROM_FFT_DESCRIPTOR_SLAVE_BASE + 8 ] [expr $sample_size *8 ]
      master_write_32 $m [expr $SGDMA_FROM_FFT_DESCRIPTOR_SLAVE_BASE + 0xc ] 0x80001000
      
      set y0 [master_read_32 $m $DATA_BASE  $sample_size]
#format up the arrays.
      foreach element $y0 {
	lappend view_data $index
	# upper 16 bit are the real onse so we need to whift it down. 
	#set element [expr $element >>16 ]
	lappend view_data $element
#need to sign extend.
	if {$element & 0x8000} {
	  set element [expr  int( $element | 0xffffffffffff0000) ]
	}
	lappend view_data "[format %d $element ]"
	lappend graph_data [list $index $element] 
	incr index
      }

      dashboard_set_property $dash scopeChart series $graph_data
      dashboard_set_property $dash scopeRawDataTable contents $view_data


      set y1 [master_read_32 $m $RESULT_BASE  [expr $sample_size*2]]

#Check to make sure the fft is done
      set status_to [master_read_32 $m $SGDMA_TO_FFT_CSR_BASE 1]
      set status_from [master_read_32 $m $SGDMA_FROM_FFT_CSR_BASE 1]
      if { [expr $status_to & 0x1]} {
	puts "SGDMA to FFT is still busy - $status_to"
      }
      if { [expr $status_from & 0x1] } {
	puts "SGDMA from FFT is still busy - $status_from"
      }

  
      set index 0
      for {set i 0} {$i < $sample_size} {incr i} {
	set temp_r [lindex $y1 [expr $i*2 ]]
	lappend view_data_r $index
	lappend view_data_r $temp_r
#need to sign extend.
	if {$temp_r & 0x80000000} {
	  set temp_r [expr  int( $temp_r | 0xffffffff00000000) ]
	}
	lappend view_data_r "[format %d $temp_r ]"
	lappend graph_data_r [list $index $temp_r]
		
	set temp_i [lindex $y1 [expr $i*2 + 1]]	
	lappend view_data_i $index
	lappend view_data_i $temp_i
#need to sign extend.
	if {$temp_i & 0x80000000} {
	  set temp_i [expr  int( $temp_i | 0xffffffff00000000) ]
	}
	  lappend view_data_i "[format %d $temp_i ]"
	  lappend graph_data_i [list $index $temp_i] 
	  incr index
      }
      dashboard_set_property $dash scopeChart_r series $graph_data_r
      dashboard_set_property $dash scopeRawDataTable_r contents $view_data_r
      dashboard_set_property $dash scopeChart_i series $graph_data_i
      dashboard_set_property $dash scopeRawDataTable_i contents $view_data_i
}

proc set_sample_size { index } {
    global sample_size
    global sample_list
    set sample_size [lindex $sample_list $index]
    puts "sample size = $sample_size"
}



