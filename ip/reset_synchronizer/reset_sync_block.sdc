#Since the synchronizer will resync the reset input we are cutting the input reset into the resync register.
set_false_path -to [get_pins -compatibility_mode -nocase -nowarn *|reset_sync_block*|synchronizer_reg*]
