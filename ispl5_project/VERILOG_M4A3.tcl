
########## Tcl recorder starts at 09/19/25 06:19:01 ##########

set version "5.0"
set proj_dir "C:/users/smooker/cpld"
cd $proj_dir

# Get directory paths
set pver $version
regsub -all {\.} $pver {_} pver
set lscfile "lsc_"
append lscfile $pver ".ini"
set lsvini_dir [lindex [array get env LSC_INI_PATH] 1]
set lsvini_path [file join $lsvini_dir $lscfile]
if {[catch {set fid [open $lsvini_path]} msg]} {
	 puts "File Open Error: $lsvini_path"
	 return false
} else {set data [read $fid]; close $fid }
foreach line [split $data '\n'] { 
	set lline [string tolower $line]
	set lline [string trim $lline]
	if {[string compare $lline "\[paths\]"] == 0} { set path 1; continue}
	if {$path && [regexp {^\[} $lline]} {set path 0; break}
	if {$path && [regexp {^bin} $lline]} {set cpld_bin $line; continue}
	if {$path && [regexp {^fpgapath} $lline]} {set fpga_dir $line}}

set cpld_bin [string range $cpld_bin [expr [string first "=" $cpld_bin]+1] end]
regsub -all "\"" $cpld_bin "" cpld_bin
set cpld_bin [file join $cpld_bin]
set install_dir [string range $cpld_bin 0 [expr [string first "ispcpld" $cpld_bin]-2]]
regsub -all "\"" $install_dir "" install_dir
set install_dir [file join $install_dir]
set fpga_dir [string range $fpga_dir [expr [string first "=" $fpga_dir]+1] end]
regsub -all "\"" $fpga_dir "" fpga_dir
set fpga_dir [file join $fpga_dir]

switch $tcl_platform(platform) {
   windows {
      set fpga_bin [file join $fpga_dir "bin" "nt"]
	     if {[string match "*$fpga_bin;*" $env(PATH)] == 0 } {
	        set env(PATH) "$fpga_bin;$env(PATH)" } }
   unix {
      set fpga_bin [file join $fpga_dir "bin" "sol"]
      if {[string match "*$fpga_bin;*" $env(PATH)] == 0 } {
         set env(PATH) "$fpga_bin;$env(PATH)"}}}

if {[string match "*$cpld_bin;*" $env(PATH)] == 0 } {
   set env(PATH) "$cpld_bin;$env(PATH)" }

lappend auto_path [file join $install_dir "ispcpld" "tcltk" "lib" "ispwidget" "runproc"]
package require runcmd

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" smoo.v -p \"$install_dir/ispcpld/generic\" -predefine verilog_m4a3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 09/19/25 06:19:01 ###########


########## Tcl recorder starts at 09/19/25 06:19:22 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open smoo.cmd w} rspFile] {
	puts stderr "Cannot create response file smoo.cmd: $rspFile"
} else {
	puts $rspFile "PROJECT: smoo
working_path: \"$proj_dir\"
module: smoo
verilog_file_list: verilog_m4a3.h smoo.v
output_file_name: smoo
suffix_name: edi
part: m4a3-64/32-7vc
vlog_std_v2001: true
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/synpwrap\" -e smoo -target mach"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete smoo.cmd

########## Tcl recorder end at 09/19/25 06:19:22 ###########


########## Tcl recorder starts at 09/19/25 06:19:51 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open smoo.cmd w} rspFile] {
	puts stderr "Cannot create response file smoo.cmd: $rspFile"
} else {
	puts $rspFile "PROJECT: smoo
working_path: \"$proj_dir\"
module: smoo
verilog_file_list: verilog_m4a3.h smoo.v
output_file_name: smoo
suffix_name: edi
part: m4a3-64/32-7vc
vlog_std_v2001: true
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/synpwrap\" -e smoo -target mach"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete smoo.cmd

########## Tcl recorder end at 09/19/25 06:19:51 ###########


########## Tcl recorder starts at 09/19/25 06:21:28 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open smoo.cmd w} rspFile] {
	puts stderr "Cannot create response file smoo.cmd: $rspFile"
} else {
	puts $rspFile "PROJECT: smoo
working_path: \"$proj_dir\"
module: smoo
verilog_file_list: verilog_m4a3.h smoo.v
output_file_name: smoo
suffix_name: edi
part: m4a3-64/32-7vc
vlog_std_v2001: true
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/synpwrap\" -e smoo -target mach"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete smoo.cmd

########## Tcl recorder end at 09/19/25 06:21:28 ###########


########## Tcl recorder starts at 09/19/25 06:23:22 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" smoo.v -p \"$install_dir/ispcpld/generic\" -predefine verilog_m4a3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 09/19/25 06:23:22 ###########


########## Tcl recorder starts at 09/19/25 06:23:33 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open smoo.cmd w} rspFile] {
	puts stderr "Cannot create response file smoo.cmd: $rspFile"
} else {
	puts $rspFile "PROJECT: smoo
working_path: \"$proj_dir\"
module: smoo
verilog_file_list: verilog_m4a3.h smoo.v
output_file_name: smoo
suffix_name: edi
part: m4a3-64/32-7vc
vlog_std_v2001: true
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/synpwrap\" -e smoo -target mach"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete smoo.cmd

########## Tcl recorder end at 09/19/25 06:23:33 ###########


########## Tcl recorder starts at 09/19/25 06:23:53 ##########

# Commands to make the Process: 
# JEDEC File
if [runCmd "\"$cpld_bin/edif2blf\" -edf smoo.edi -out smoo.bl0 -err automake.err -log smoo.log -prj verilog_m4a3 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_vcc vcc -net_gnd gnd -nbx -dse -tlw -cvt yes -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" smoo.bl0 -collapse none -reduce none -keepwires  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"smoo.bl1\" -o \"verilog_m4a3.bl2\" -omod \"verilog_m4a3\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj verilog_m4a3 -lci verilog_m4a3.lct -log verilog_m4a3.imp -err automake.err -tti verilog_m4a3.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci verilog_m4a3.lct -blifopt  verilog_m4a3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" verilog_m4a3.bl2 -sweep -mergefb -err automake.err -o verilog_m4a3.bl3  @verilog_m4a3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci verilog_m4a3.lct -dev mach4a -diofft  verilog_m4a3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" verilog_m4a3.bl3 -pla -family amdmach -idev van -o verilog_m4a3.tt2 -oxrf verilog_m4a3.xrf -err automake.err  @verilog_m4a3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/tt2tott3\" -prj verilog_m4a3 -dir $proj_dir -log verilog_m4a3.log -tti verilog_m4a3.tt2 -tto verilog_m4a3.tt3"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci verilog_m4a3.lct -dev mach4a -prefit  verilog_m4a3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -inp verilog_m4a3.tt3 -out verilog_m4a3.tt4 -err automake.err -log verilog_m4a3.log -percent verilog_m4a3.tte -mod smoo  @verilog_m4a3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blif2eqn\" verilog_m4a3.tte -o verilog_m4a3.eq3 -use_short -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/lci2vci\" -lci verilog_m4a3.lct -out verilog_m4a3.vct -log verilog_m4a3.l2v"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open verilog_m4a3.rsp w} rspFile] {
	puts stderr "Cannot create response file verilog_m4a3.rsp: $rspFile"
} else {
	puts $rspFile "-inp \"verilog_m4a3.tt4\" -vci \"verilog_m4a3.vct\" -log \"verilog_m4a3.log\" -eqn \"verilog_m4a3.eq3\" -dev mach464a -dat \"$install_dir/ispcpld/dat/mach4a/\" -msg \"$install_dir/ispcpld/dat/\" -err automake.err -tmv \"noinput.tmv\" 
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/machfitr\" \"@verilog_m4a3.rsp\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete verilog_m4a3.rsp
if [runCmd "\"$cpld_bin/lci2vci\" -vci verilog_m4a3.vco -out verilog_m4a3.lco -log verilog_m4a3.v2l"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj verilog_m4a3 -if verilog_m4a3.jed -j2s -log verilog_m4a3.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 09/19/25 06:23:53 ###########


########## Tcl recorder starts at 09/19/25 06:27:12 ##########

# Commands to make the Process: 
# Post-Fit Pinouts
# - none -
# Application to view the Process: 
# Post-Fit Pinouts
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-src verilog_m4a3.tt4 -type PLA -devfile \"$install_dir/ispcpld/dat/mach4a/mach464ace.dev\" -postfit -lci verilog_m4a3.lco
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 09/19/25 06:27:12 ###########


########## Tcl recorder starts at 09/19/25 06:29:39 ##########

# Commands to make the Process: 
# Post-Fit Pinouts
# - none -
# Application to view the Process: 
# Post-Fit Pinouts
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-src verilog_m4a3.tt4 -type PLA -devfile \"$install_dir/ispcpld/dat/mach4a/mach464ace.dev\" -postfit -lci verilog_m4a3.lco
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 09/19/25 06:29:40 ###########


########## Tcl recorder starts at 09/19/25 06:31:16 ##########

# Commands to make the Process: 
# Post-Fit Pinouts
# - none -
# Application to view the Process: 
# Post-Fit Pinouts
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-src verilog_m4a3.tt4 -type PLA -devfile \"$install_dir/ispcpld/dat/mach4a/mach464ace.dev\" -postfit -lci verilog_m4a3.lco
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 09/19/25 06:31:16 ###########


########## Tcl recorder starts at 09/19/25 06:33:25 ##########

# Commands to make the Process: 
# Constraint Editor
# - none -
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-src verilog_m4a3.tt4 -type PLA -devfile \"$install_dir/ispcpld/dat/mach4a/mach464ace.dev\" -lci \"verilog_m4a3.lct\" -touch \"verilog_m4a3.tt4\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 09/19/25 06:33:25 ###########


########## Tcl recorder starts at 09/19/25 06:37:22 ##########

# Commands to make the Process: 
# Pre-Fit Equations
if [runCmd "\"$cpld_bin/blif2eqn\" verilog_m4a3.tte -o verilog_m4a3.eq3 -use_short -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 09/19/25 06:37:22 ###########


########## Tcl recorder starts at 09/19/25 06:38:03 ##########

# Commands to make the Process: 
# Fitter Report
if [runCmd "\"$cpld_bin/lci2vci\" -lci verilog_m4a3.lct -out verilog_m4a3.vct -log verilog_m4a3.l2v"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open verilog_m4a3.rsp w} rspFile] {
	puts stderr "Cannot create response file verilog_m4a3.rsp: $rspFile"
} else {
	puts $rspFile "-inp \"verilog_m4a3.tt4\" -vci \"verilog_m4a3.vct\" -log \"verilog_m4a3.log\" -eqn \"verilog_m4a3.eq3\" -dev mach464a -dat \"$install_dir/ispcpld/dat/mach4a/\" -msg \"$install_dir/ispcpld/dat/\" -err automake.err -tmv \"noinput.tmv\" 
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/machfitr\" \"@verilog_m4a3.rsp\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete verilog_m4a3.rsp
if [runCmd "\"$cpld_bin/lci2vci\" -vci verilog_m4a3.vco -out verilog_m4a3.lco -log verilog_m4a3.v2l"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj verilog_m4a3 -if verilog_m4a3.jed -j2s -log verilog_m4a3.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 09/19/25 06:38:04 ###########


########## Tcl recorder starts at 09/19/25 06:39:48 ##########

# Commands to make the Process: 
# Post-Fit Pinouts
# - none -
# Application to view the Process: 
# Post-Fit Pinouts
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-src verilog_m4a3.tt4 -type PLA -devfile \"$install_dir/ispcpld/dat/mach4a/mach464ace.dev\" -postfit -lci verilog_m4a3.lco
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 09/19/25 06:39:48 ###########


########## Tcl recorder starts at 09/19/25 06:40:18 ##########

# Commands to make the Process: 
# JEDEC File
if [catch {open smoo.cmd w} rspFile] {
	puts stderr "Cannot create response file smoo.cmd: $rspFile"
} else {
	puts $rspFile "PROJECT: smoo
working_path: \"$proj_dir\"
module: smoo
verilog_file_list: verilog_m4a3.h smoo.v
output_file_name: smoo
suffix_name: edi
part: m4a3-64/32-7vc
vlog_std_v2001: true
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/synpwrap\" -e smoo -target mach"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete smoo.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf smoo.edi -out smoo.bl0 -err automake.err -log smoo.log -prj verilog_m4a3 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_vcc vcc -net_gnd gnd -nbx -dse -tlw -cvt yes -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" smoo.bl0 -collapse none -reduce none -keepwires  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"smoo.bl1\" -o \"verilog_m4a3.bl2\" -omod \"verilog_m4a3\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj verilog_m4a3 -lci verilog_m4a3.lct -log verilog_m4a3.imp -err automake.err -tti verilog_m4a3.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci verilog_m4a3.lct -blifopt  verilog_m4a3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" verilog_m4a3.bl2 -sweep -mergefb -err automake.err -o verilog_m4a3.bl3  @verilog_m4a3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci verilog_m4a3.lct -dev mach4a -diofft  verilog_m4a3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" verilog_m4a3.bl3 -pla -family amdmach -idev van -o verilog_m4a3.tt2 -oxrf verilog_m4a3.xrf -err automake.err  @verilog_m4a3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/tt2tott3\" -prj verilog_m4a3 -dir $proj_dir -log verilog_m4a3.log -tti verilog_m4a3.tt2 -tto verilog_m4a3.tt3"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci verilog_m4a3.lct -dev mach4a -prefit  verilog_m4a3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -inp verilog_m4a3.tt3 -out verilog_m4a3.tt4 -err automake.err -log verilog_m4a3.log -percent verilog_m4a3.tte -mod smoo  @verilog_m4a3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blif2eqn\" verilog_m4a3.tte -o verilog_m4a3.eq3 -use_short -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/lci2vci\" -lci verilog_m4a3.lct -out verilog_m4a3.vct -log verilog_m4a3.l2v"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open verilog_m4a3.rsp w} rspFile] {
	puts stderr "Cannot create response file verilog_m4a3.rsp: $rspFile"
} else {
	puts $rspFile "-inp \"verilog_m4a3.tt4\" -vci \"verilog_m4a3.vct\" -log \"verilog_m4a3.log\" -eqn \"verilog_m4a3.eq3\" -dev mach464a -dat \"$install_dir/ispcpld/dat/mach4a/\" -msg \"$install_dir/ispcpld/dat/\" -err automake.err -tmv \"noinput.tmv\" 
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/machfitr\" \"@verilog_m4a3.rsp\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete verilog_m4a3.rsp
if [runCmd "\"$cpld_bin/lci2vci\" -vci verilog_m4a3.vco -out verilog_m4a3.lco -log verilog_m4a3.v2l"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj verilog_m4a3 -if verilog_m4a3.jed -j2s -log verilog_m4a3.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 09/19/25 06:40:18 ###########

